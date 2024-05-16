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

## Can use the "random_string" resource to create
## a random suffix for the database name.  Azure
## database names are globally unique.
# resource "random_string" "db_name_suffix" {
#   length  = 4
#   upper   = false
#   special = false
# }

resource "azurerm_resource_group" "example" {
  name     = "example-resources-${var.random_char}"
  location = "West US"
}

module "this" {
  source                 = "../../"
  location               = "West US"
  resource_group_name    = azurerm_resource_group.example.name
  administrator_login    = "my_admin"
  administrator_password = "Password1!"
  # name_suffix            = "-${random_string.db_name_suffix.result}"
  name_suffix = "-${var.random_char}"

  # This cannot be set if public_network_access_enabled = false
  # firewall_rules = [
  #   {
  #     "name": "test1",
  #     "start_ip": "10.0.0.0",
  #     "end_ip": "10.0.0.10"
  #   },
  # ]

  tags = {
    "unit-test" : "true",
  }
}

output "server_name" {
  value = module.this.server_name
}

output "server_fqdn" {
  value = module.this.server_fqdn
}
