output "aws_public_ip" {
  value = aws_instance.hashicups.public_ip
}

output "azure_public_ip" {
  value = azurerm_linux_virtual_machine.hashicups.public_ip_address
}