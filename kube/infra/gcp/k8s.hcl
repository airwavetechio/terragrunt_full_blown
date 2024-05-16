locals {
  common_vars = jsondecode(file(find_in_parent_folders("terraform.tfvars.json")))
}

dependency "gke" {
  config_path = "../gke"
  mock_outputs = {
    location = "mocked"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "project" {
  config_path = "../project"
  mock_outputs = {
    project_name = "mocked"
    project_id   = "mocked"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

generate "gcp_credentials" {
  path              = "generated_service_account.json"
  if_exists         = "overwrite"
  contents          = file("service_account.json")
  disable_signature = true
}

generate "k8s_provider" {
  path      = "k8s_provider_generated.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.59.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "4.59.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.19.0"
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

data "google_client_config" "provider" {}

data "google_container_cluster" "gke_cluster" {
  name     = "${dependency.project.outputs.project_name}"
  location = "${dependency.gke.outputs.location}"
  project      = "${dependency.project.outputs.project_id}"
}

provider "kubernetes" {
  host  = "https://$${data.google_container_cluster.gke_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,)
}

provider "helm" {
  kubernetes {
    host  = "https://$${data.google_container_cluster.gke_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,)
  }
}
EOF
}



# generate "k8s_provider" {
#   path      = "k8s_provider_generated.tf"
#   if_exists = "overwrite"
#   contents = <<EOF
# data "google_client_config" "provider" {}

# data "google_container_cluster" "gke_cluster" {
#   name     = "${dependency.project.outputs.project_name}"
#   location = "${dependency.gke.outputs.location}"
#   project      = "${dependency.project.outputs.project_id}"
# }

# provider "kubernetes" {
#   host  = "https://$${data.google_container_cluster.gke_cluster.endpoint}"
#   token = data.google_client_config.provider.access_token
#   cluster_ca_certificate = base64decode(
#     data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,
#   )
# }

# EOF
# }
