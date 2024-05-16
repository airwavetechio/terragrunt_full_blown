terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

# Azure requires flexible servers live in their own subnet
resource "azurerm_subnet" "postgres" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  version             = var.server_version
  # delegated_subnet_id    = var.private_link_subnet
  # private_dns_zone_id    = azurerm_private_dns_zone.postgres.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  zone                   = var.zone

  storage_mb = var.storage_mb
  sku_name   = var.sku_name
  tags       = var.tags
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "postgres" {
  count            = length(var.firewall_rules)
  name             = "${var.name}-${count.index}"
  server_id        = azurerm_postgresql_flexible_server.postgres.id
  start_ip_address = var.firewall_rules[count.index]
  end_ip_address   = var.firewall_rules[count.index]

  depends_on = [
    azurerm_postgresql_flexible_server.postgres
  ]
}

resource "azurerm_postgresql_flexible_server_configuration" "postgres" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  value     = var.require_secure_transport_enabled
}

resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  value     = "UUID-OSSP"
}