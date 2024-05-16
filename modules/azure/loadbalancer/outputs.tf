output "id" {
  value       = azurerm_lb.this.id
  description = "The Load Balancer ID."
}

output "public_ip_address" {
  value = azurerm_public_ip.this.ip_address
}
