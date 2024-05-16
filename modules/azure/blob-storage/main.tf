terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "this" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  access_tier               = var.access_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each              = var.buckets
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = var.storage_container_access_type
}
