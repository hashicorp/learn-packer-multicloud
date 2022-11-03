provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

variable "AZURE_RESOURCE_GROUP" {
  type = string
}

resource "azurerm_resource_group" "packer" {
  name     = var.AZURE_RESOURCE_GROUP #"learn-packer-multicloud-rg"
  location = "West US 3"
}

output "packer-rg" {
  value = azurerm_resource_group.packer.name
}