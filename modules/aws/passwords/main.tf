locals {
  database_instances = distinct(var.databases[*].instance)
}

terraform {
  required_version = ">= 1.0.9"
}

# External passwords
resource "random_password" "postgres_admin_passwords" {
  for_each = toset(local.database_instances)
  length   = 16
  special  = false
}

resource "random_password" "keycloak_password" {
  length  = 16
  special = false
}

# Internal passwords
resource "random_password" "airwave_realm_admin_password" {
  length  = 16
  special = false
}

resource "random_password" "database_user_passwords" {
  for_each = toset(var.databases[*].name)
  length   = 16
  special  = false
}

resource "random_password" "minio_secret_key" {
  length  = 16
  special = false
}

resource "random_password" "keycloak_login_server_client_secret" {
  length  = 32
  special = false
}

resource "random_password" "oauth2_proxy_cookie_password" {
  length  = 32
  special = false
}
