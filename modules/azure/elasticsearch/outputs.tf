output "elasticsearch_public_ip_id" {
  value = azurerm_public_ip.elasticsearch.id
}

output "elasticsearch_public_ip_address" {
  value = azurerm_public_ip.elasticsearch.ip_address
}
