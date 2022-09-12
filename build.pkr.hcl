packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.9"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 1.0.6"
    }
  }
}

locals {
  date = formatdate("HHmm", timestamp())
}

source "amazon-ebs" "ubuntu-lts" {
  region = "us-west-1"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false

  ami_name    = "hashicups_{{timestamp}}"
  ami_regions = ["us-west-1"]
}

source "azure-arm" "ubuntu-lts" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }

  client_id                         = var.arm_client_id
  client_secret                     = var.arm_client_secret
  subscription_id                   = var.arm_subscription_id
  managed_image_resource_group_name = var.resource_group

  os_type         = "Linux"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_publisher = "Canonical"
  image_sku       = "22_04"

  vm_size = "Standard_B1s"
}

build {
  # HCP Packer settings
  hcp_packer_registry {
    bucket_name = "learn-packer-multicloud-hashicups"
    description = <<EOT
This is an image for HashiCups.
    EOT

    bucket_labels = {
      "hashicorp-learn" = "learn-packer-multicloud-hashicups",
    }
  }

  sources = [
    "source.amazon-ebs.ubuntu-lts",
  ]

  source "source.azure-arm.ubuntu-lts" {
    name               = "hashicups"
    location           = "westus"
    managed_image_name = "hashicups_${local.date}"
  }

  # systemd unit for HashiCups service
  provisioner "file" {
    source      = "hashicups.service"
    destination = "/tmp/hashicups.service"
  }

  # Set up HashiCups
  provisioner "shell" {
    scripts = [
      "setup-deps-hashicups.sh"
    ]
  }
}
