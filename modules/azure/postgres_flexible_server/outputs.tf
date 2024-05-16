output "server_name" {
  value = azurerm_postgresql_flexible_server.postgres.name
}

output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "administrator_login" {
  value = azurerm_postgresql_flexible_server.postgres.administrator_login
}

output "administrator_password" {
  value = azurerm_postgresql_flexible_server.postgres.administrator_password
}

output "server_id" {
  description = "The resource id of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.postgres.id
}

