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
  location = "West US"
}

module "dns" {
  source       = "../../"
  resource_group = azurerm_resource_group.example.name
  dns_zone_domain = "example-${var.random_char}.com"
  record_name = "test"
  tags = {
      "unit-test": "true",
  }
}

output "azurerm_dns_zone_id" {
  value       = module.dns.azurerm_dns_zone_id
}

output "dns_a_record_fqdn" {
  value = module.dns.dns_a_record_fqdn
}
