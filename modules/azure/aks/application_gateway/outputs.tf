output "cluster_ingress_ip" {
  description = "The Public IP of the application gateway"
  value       = azurerm_public_ip.cluster.ip_address
}

output "id" {
  description = "The ID of the Application Gateway."
  value       = azurerm_application_gateway.cluster.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS Subnet"
  value       = data.azurerm_subnet.akssubnet.id
}

output "public_ip" {
  description = "The PUBLIC IP Address"
  value       = azurerm_public_ip.cluster.ip_address
}