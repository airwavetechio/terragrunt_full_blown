output "elasticsearch_public_ip_id" {
  value = azurerm_public_ip.elasticsearch.id
}

output "elasticsearch_public_ip_address" {
  value = azurerm_public_ip.elasticsearch.ip_address
}


output "elasticsearch_private_ip_address" {
  value = azurerm_linux_virtual_machine.elasticsearch.private_ip_address
}

output "elasticsearch_instance_id" {
  value = azurerm_linux_virtual_machine.elasticsearch.id
}