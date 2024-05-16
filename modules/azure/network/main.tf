terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.name_postfix}"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.name_postfix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "subnet-${var.name_postfix}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_subnet" "private_link" {
  name                                           = "subnet-privatelink-${var.name_postfix}"
  resource_group_name                            = azurerm_resource_group.this.name
  virtual_network_name                           = azurerm_virtual_network.this.name
  address_prefixes                               = var.subnet_address_prefix_private_link
  private_endpoint_network_policies_enabled      = true
}
