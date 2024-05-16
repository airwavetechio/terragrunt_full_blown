variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
}

variable "subdomain" {
  type        = string
  description = "The subdomain that will be prefixed to all resources"
}

terraform {
  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      version = "~>4.1.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      "unit-test" : "true",
    }
  }
}

module "storage" {
  source = "../../"

  subdomain           = var.subdomain
  buckets             = ["analysis-${var.random_char}", "core-${var.random_char}"]
}

output "storage_container_info" {
  value = module.storage.storage_container_info
}