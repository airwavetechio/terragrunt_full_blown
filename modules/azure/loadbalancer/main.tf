terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}

resource "azurerm_public_ip" "this" {
  name                = "PublicIPForLB-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_lb" "this" {
  name                = "loadbalancer-${var.subdomain}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  sku_tier            = var.sku_tier

  frontend_ip_configuration {
    name                          = "LBPublicIPAddress-${var.subdomain}"
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "BackEndAddressPool-${var.subdomain}"
}

resource "azurerm_network_interface_backend_address_pool_association" "docker_swarm_master" {
  count                   = length(var.docker_swarm_masters_networking_interface_id)
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
  ip_configuration_name   = "${var.subdomain}-${count.index}"
  network_interface_id    = var.docker_swarm_masters_networking_interface_id[count.index]
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id     = azurerm_lb.this.id
  name                = "Healthprobe"
  port                = var.probe_port
  protocol            = var.probe_protocol
  request_path        = var.request_path
  interval_in_seconds = var.interval_in_seconds
  number_of_probes    = var.number_of_probes
}

resource "azurerm_lb_rule" "rule01" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "LBRule01"
  protocol                       = var.rule01_protocol
  frontend_port                  = var.rule01_frontend_port
  backend_port                   = var.rule01_backend_port
  frontend_ip_configuration_name = "LBPublicIPAddress-${var.subdomain}"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}

resource "azurerm_lb_rule" "rule02" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "LBRule02"
  protocol                       = var.rule02_protocol
  frontend_port                  = var.rule02_frontend_port
  backend_port                   = var.rule02_backend_port
  frontend_ip_configuration_name = "LBPublicIPAddress-${var.subdomain}"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
}

