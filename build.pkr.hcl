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

source "amazon-ebs" "ubuntu-hirsute" {
  region = "us-west-1"
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-hirsute-21.04-amd64-server-*"
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

source "azure-arm" "ubuntu-hirsute" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }

  client_id                         = var.arm_client_id
  client_secret                     = var.arm_client_secret
  subscription_id                   = var.arm_subscription_id
  managed_image_resource_group_name = var.resource_group

  os_type         = "Linux"
  image_offer     = "0001-com-ubuntu-server-hirsute"
  image_publisher = "Canonical"
  image_sku       = "21_04"

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
    "source.amazon-ebs.ubuntu-hirsute",
  ]

  source "source.azure-arm.ubuntu-hirsute" {
    name               = "hashicups"
    location           = "westus"
    managed_image_name = "hashicups_${local.date}"
  }

  ## HashiCups
  # Add startup script that will run hashicups on instance boot
  provisioner "file" {
    source      = "setup-deps-hashicups.sh"
    destination = "/tmp/setup-deps-hashicups.sh"
  }

  # Move temp files to actual destination
  # Must use this method because their destinations are protected 
  provisioner "shell" {
    inline = [
      "sudo cp /tmp/setup-deps-hashicups.sh /var/lib/cloud/scripts/per-boot/setup-deps-hashicups.sh",
    ]
  }
}
