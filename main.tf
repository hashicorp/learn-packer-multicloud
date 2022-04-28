provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "packer" {
  name     = "learn-packer-multicloud-rg"
  location = "West US"
}

output "packer-rg" {
  value = azurerm_resource_group.packer.name
}