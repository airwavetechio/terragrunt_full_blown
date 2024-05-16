terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_private_dns_zone" "this" {
  count               = var.isPiensoStack ? 0 : 1
  name                = var.domain
  resource_group_name = var.resource_group
  tags                = var.tags
}

resource "azurerm_private_dns_a_record" "this" {
  count               = var.isPiensoStack ? 0 : 1
  name                = var.subdomain
  zone_name           = azurerm_private_dns_zone.this[0].name
  resource_group_name = var.resource_group
  ttl                 = var.ttl
  records             = var.record_ip
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  count                 = var.isPiensoStack ? 0 : 1
  name                  = var.domain
  resource_group_name   = var.resource_group
  private_dns_zone_name = azurerm_private_dns_zone.this[0].name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
}
