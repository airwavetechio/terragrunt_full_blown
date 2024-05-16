output "postgres_public_ip_address" {
  value = azurerm_public_ip.postgres.ip_address
}

output "postgres_private_ip_address" {
  value = azurerm_linux_virtual_machine.postgres.private_ip_address
}

output "postgres_instance_id" {
  value = azurerm_linux_virtual_machine.postgres.id
}

output "postgres_instance_name" {
  value = azurerm_linux_virtual_machine.postgres.name
}

output "server_info" {
  value = {
    id                     = azurerm_linux_virtual_machine.postgres.id,
    name                   = azurerm_linux_virtual_machine.postgres.name,
    fqdn                   = azurerm_linux_virtual_machine.postgres.name,
    administrator_login    = azurerm_linux_virtual_machine.postgres.admin_username,
    administrator_password = "",
    tag                    = var.tags
  }
}