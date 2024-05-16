variable "location" {
  type        = string
  description = "Azure Region with availability zones"
}

variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
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

module "redis" {
  source = "../../"
  
  subdomain                = "test-${var.random_char}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
 
  tags = {
    "unit-test" : "true",
  }
}

output "hostname" {
    value = module.redis.hostname
    description = "The Hostname of the Redis Instance"
}
