variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
}

variable "location" {
  type        = string
  description = "Azure Region with availability zones"
}

variable "subdomain" {
  type        = string
  description = "The subdomain that will be prefixed to all resources"
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

module "storage" {
  source = "../../"

  subdomain           = var.subdomain
  buckets             = ["analysis${var.random_char}", "core${var.random_char}"]
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location
  tags = {
    "unit-test" : "true",
  }
}

output "primary_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}

output "blob_id" {
  value = module.storage.blob_id
}