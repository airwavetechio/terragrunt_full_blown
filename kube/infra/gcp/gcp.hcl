locals {
  common_vars = jsondecode(file("terraform.tfvars.json"))
}

generate "gcp_provider" {
  path      = "gcp_provider_generated.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  registry_auth {
    address  = "index.docker.io"
    username = "${local.common_vars.docker_registry_username}"
    password = "${local.common_vars.docker_registry_password}"
  }
}

provider "google" {
  credentials     = file("generated_service_account.json")
  zone = "${local.common_vars.location}"
  billing_project = "${local.common_vars.gke_billing_account}"
}

provider "google-beta" {
  zone        = "${local.common_vars.location}"
  credentials = file("generated_service_account.json")
  billing_project = "${local.common_vars.gke_billing_account}"
}

EOF
}

generate "gcp_credentials" {
  path      = "generated_service_account.json"
  if_exists = "overwrite"
  contents = file("service_account.json")
  disable_signature = true
}