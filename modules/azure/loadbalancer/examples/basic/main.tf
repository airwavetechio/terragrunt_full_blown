variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
}

variable "location" {
  type        = string
  description = "Azure Region with availability zones"
}

terraform {
  required_version = ">= 1.0.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources-${var.random_char}"
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-test-${var.random_char}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  tags = {
    "unit-test" : "true",
  }
}

resource "azurerm_subnet" "example" {
  name                 = "subnet-test-${var.random_char}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_public_ip" "example_master" {
  count               = 2
  name                = "public-ip-master-test-${var.random_char}-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"

  tags = {
    "unit-test" : "true",
  }
}

resource "azurerm_network_interface" "example_master" {
  count               = 2
  name                = "nic-master-test-${var.random_char}-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "test-${var.random_char}-${count.index}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_master[count.index].id
  }

  tags = {
    "unit-test" : "true",
  }
}

resource "azurerm_public_ip" "example_worker" {
  count               = 2
  name                = "public-ip-worker-test-${var.random_char}-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"

  tags = {
    "unit-test" : "true",
  }
}

resource "azurerm_network_interface" "example_worker" {
  count               = 2
  name                = "nic-worker-test-${var.random_char}-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "test-${var.random_char}-${count.index}"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_worker[count.index].id
  }

  tags = {
    "unit-test" : "true",
  }
}

module "loadbalancer" {
  source = "../../"

  subdomain           = "test-${var.random_char}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  docker_swarm_master_networking_interface_ids = azurerm_network_interface.example_master.*.id
  docker_swarm_worker_networking_interface_ids = azurerm_network_interface.example_worker.*.id

  tags = {
    "unit-test" : "true",
  }
}

output "lb_id" {
  value = module.loadbalancer.id
}
