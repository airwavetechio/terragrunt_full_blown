terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_redis_cache" "this" {
  name                = "${var.subdomain}-cache"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = var.enable_non_ssl_port
  minimum_tls_version = var.minimum_tls_version
  redis_version       = var.redis_version

  tags = var.tags

  redis_configuration {}

  # Azure Redis Cache takes a long time to provision
  timeouts {
    create = "4h"
    delete = "4h"
  }
}