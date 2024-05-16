terraform {
  required_version = ">= 1.0.9"
}

module "passwords" {
  source = "../../"
}

output "postgres_admin_passwords" {
  value     = module.passwords.postgres_admin_passwords
  sensitive = true
}
