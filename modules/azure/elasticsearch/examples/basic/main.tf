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

module "elasticsearch" {
  source = "../../"

  subdomain           = "test-${var.random_char}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id
  public_key          = file("./files/id_rsa.pub")

  tags = {
    "unit-test" : "true",
  }
}

output "elasticsearch_vm_id" {
  value = module.elasticsearch.elasticsearch_vm_id
}
