variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
}

terraform {
  required_version = ">= 1.0.9"
}

provider "aws" {
  region = "us-west-2"
  default_tags  {
    tags = {
      "unit-test": "true"
    }
  }
}

module "dns" {
  source       = "../../"
  domain = "example-${var.random_char}.com"
  subdomain = "test"
  record_ip = ["1.1.1.1"]
}

output "aws_dns_zone_id" {
  value       = module.dns.dns_a_zone_id
}

output "dns_a_record_fqdn" {
  value = module.dns.dns_a_record_fqdn
}
