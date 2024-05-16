
output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "virtual_network_id" {
  value = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_name" {
  value = azurerm_subnet.this.name
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}

output "subnet_id_private_link_id" {
  value = azurerm_subnet.private_link.id
}
