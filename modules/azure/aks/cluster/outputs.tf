output "cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}

output "client_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
}

output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.cluster.kube_config
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.cluster.oidc_issuer_url
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}


output "cluster_egress_ip" {
  value = data.azurerm_public_ip.cluster.ip_address
}

# output "subnet_id" {
#   value = azurerm_subnet.cluster.id
# }

# output "azurerm_resource_group_id" {
#   value = data.azurerm_resource_group.cluster.id
# }

# output "azurerm_resource_group_name" {
#   value = data.azurerm_resource_group.cluster.name
# }

# output "azurerm_resource_group_location" {
#   value = data.azurerm_resource_group.cluster.location
# }


# output "k3s_token" {
#   value = random_password.k3s_token.result
# }

# output "redis_password" {
#   value = random_password.redis_password.result
# }

# output "minio_password" {
#   value = random_password.minio_password.result

# }

# output "database_master_password" {
#   value = random_password.database_master_password.result

# }

# output "app_database_password" {
#   value = random_password.app_database_password.result

# }

# output "keycloak_password" {
#   value = random_password.keycloak_password.result

# }