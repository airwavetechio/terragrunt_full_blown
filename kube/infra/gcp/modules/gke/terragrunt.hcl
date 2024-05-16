terraform {
  source = "../../../../modules/gcp/gke"
}

include "gcp_provider" {
  path = find_in_parent_folders("gcp.hcl")
}

include "backend" {
  path = find_in_parent_folders("backend.hcl")
}

dependency "project" {
  config_path = "../project"
  mock_outputs = {
    project_id = "mocked"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_name       = "mock"
    vpc_subnetwork = "mock"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  project_id     = dependency.project.outputs.project_id
  vpc_name       = dependency.vpc.outputs.vpc_name
  vpc_subnetwork = dependency.vpc.outputs.vpc_subnetwork
}
