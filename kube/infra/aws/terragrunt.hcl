
locals {
  # Load common variables shared across all accounts
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  # Load environment level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  tf_vars = jsondecode(file("terraform.tfvars.json"))

}

# Generate an AWS provider block
generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
    http = {
      source  = "terraform-aws-modules/http"
      version = "2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}


EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
 region = "${local.tf_vars.aws_region}"
}
# Comment out provider for local usage
provider "google" {
  credentials     = file("generated_service_account.json")
}
provider "docker" {
  registry_auth {
    address  = "index.docker.io"
    username = "${local.tf_vars.docker_registry_username}"
    password = "${local.tf_vars.docker_registry_password}"
  }
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "airwave-terraform-state"
    key            = "${local.tf_vars.airwave_stack_name}/${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.tf_vars.aws_region}"
    dynamodb_table = "airwave-terraform-state-lock"
  }
}
EOF
}

### Comment out for local usage
generate "gcp_credentials" {
  path              = "generated_service_account.json"
  if_exists         = "overwrite"
  contents          = file("service_account.json")
  disable_signature = true
}

retryable_errors = jsondecode(file(find_in_parent_folders("retryable-errors.json")))
