terraform {
  source = "../../../../modules/gcp/ingress"
}

include "k8s_provider" {
  path = find_in_parent_folders("k8s.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

dependency "baremetal" {
  config_path = "../baremetal"
  mock_outputs = {
    foundation_stack = {
      namespace = "mocked"
      proxy = {
        app_name = "mocked"
      }
    }
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
}

dependency "postgres" {
  config_path  = "../postgres"
  skip_outputs = true
}

dependency "namespaces" {
  config_path  = "../namespaces"
  skip_outputs = true
}

dependency "redis" {
  config_path  = "../redis"
  skip_outputs = true
}

dependency "vpc" {
  config_path  = "../vpc"
  skip_outputs = true
}

dependency "proxy" {
  config_path  = "../proxy"
  skip_outputs = true
}

dependency "airwave-dns" {
  config_path  = "../airwave-dns"
  skip_outputs = true
}

locals {
  # Load common variables shared across all accounts
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  app_name        = dependency.baremetal.outputs.foundation_stack.proxy.app_name
  namespace       = dependency.baremetal.outputs.foundation_stack.namespace
  gke_project_id  = dependency.project.outputs.project_id
  ssl_policy_name = "strict-ssl-policy"
}
