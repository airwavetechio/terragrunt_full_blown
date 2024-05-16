output "server_name" {
  value = azurerm_postgresql_server.server.name
}

# output "server_info" {
#   #sensitive = true
#   value = tomap({
#     for k in azurerm_postgresql_server.server : k => {
#       id   = k.id,
#       name = k.name,
#       fqdn = k.fqdn,
#       #identity = azurerm_postgresql_server.server.identity,
#       administrator_login = k.administrator_login,
#       administrator_login_password = nonsensitive(k.administrator_login_password),
#       private_ip = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address,
#     }
#   })
# }

output "server_fqdn" {
  value = azurerm_postgresql_server.server.fqdn
}

# output "azurerm_postgresql_server_all" {
#   value = azurerm_postgresql_server.server.*
# }

output "administrator_login" {
  value = azurerm_postgresql_server.server.administrator_login
}

output "administrator_password" {
  value     = azurerm_postgresql_server.server.administrator_login_password
}

output "server_id" {
  description = "The resource id of the PostgreSQL server"
  value       = azurerm_postgresql_server.server.id
}

