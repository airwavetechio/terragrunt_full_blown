locals {
  database_instances = distinct(var.databases[*].instance)
}

terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_postgresql_server" "server" {
  name                = "postgres-${var.name_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name

  storage_mb                   = var.storage_mb
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  administrator_login              = var.administrator_login
  administrator_login_password     = var.administrator_password
  version                          = var.server_version
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
  public_network_access_enabled    = var.public_network_access_enabled
  auto_grow_enabled                = var.auto_grow_enabled

  tags = var.tags
}

resource "azurerm_private_endpoint" "this" {
  name                = "postgres-${var.name_suffix}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_link_subnet

  private_service_connection {
    name                           = "postgres-${var.name_suffix}-privateserviceconnection"
    private_connection_resource_id = azurerm_postgresql_server.server.id
    subresource_names              = [ "postgresqlServer" ]
    is_manual_connection           = false
  }
}

# For each database that is created
# Loop through the firewall rules in the "firewall_rules" list and apply it to each DB
module "azurerm_postgresql_firewall_rule" {
  source = "./modules/firewall_rules"

  resource_group_name  = var.resource_group_name
  server_name          = azurerm_postgresql_server.server.name
  firewall_rules       = var.firewall_rules
  firewall_rule_prefix = var.firewall_rule_prefix
}

# For each database that is created
# Loop through the network rules in the "vnet_rules" list and apply it to each DB
module "azurerm_postgresql_virtual_network_rule" {
  source = "./modules/virtual_network_rules"

  resource_group_name   = var.resource_group_name
  server_name           = azurerm_postgresql_server.server.name
  vnet_rules            = var.vnet_rules
  vnet_rule_name_prefix = var.vnet_rule_name_prefix
}

# For each database that is created
# Loop through the DB configs in the "postgresql_configurations" map and apply it to each DB
module "azurerm_postgresql_configuration" {
  source = "./modules/configurations"

  for_each                  = toset(local.database_instances)
  resource_group_name       = var.resource_group_name
  server_name               = azurerm_postgresql_server.server.name
  postgresql_configurations = var.postgresql_configurations
}
