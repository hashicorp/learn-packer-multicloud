terraform {
  cloud {
    organization = "hashicorp-learn"
    workspaces {
      name = "learn-packer-multicloud"
    }
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.10.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.2.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.26.0"
    }
  }
  required_version = ">= 1.1.0"
}