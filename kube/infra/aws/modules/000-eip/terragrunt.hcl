# Include all settings from the root terragrunt.hcl file
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/aws/eip///"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Load common variables shared across all accounts
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  # Load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Load Terraform vars as parameters
  tf_vars = jsondecode(file(find_in_parent_folders("terraform.tfvars.json")))

  tags = {
    ops_env              = local.tf_vars.airwave_stack_name
    ops_managed_by       = "terraform"
    ops_source_repo      = local.common_vars.locals.repository_name
    ops_source_repo_path = "${local.common_vars.locals.base_repository_path}/${path_relative_to_include()}"
    ops_owners           = "devops"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  aws_eip_count = 3
  tags          = local.tags
}
