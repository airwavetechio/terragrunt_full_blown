terraform {
  source = "../../../../modules/gcp/vpc"
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

dependency "api" {
  config_path  = "../api"
  skip_outputs = true
}

inputs = {
  project_id = dependency.project.outputs.project_id
}
