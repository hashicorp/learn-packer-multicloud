terraform {
  cloud {
    workspaces {
      name = "learn-packer-multicloud"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.44.0"
    }
  }
  required_version = ">= 1.2.0"
}
