# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# Can't pull directly from Github because of this issue
# https://github.com/aws-ia/terraform-aws-eks-blueprints/issues/825#issuecomment-1271588438
terraform {
  source = "../../../../../modules/aws/eks/nvidia-plugin///"
}

generate "k8s_provider" {
  path      = "k8s_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = templatefile(
    find_in_parent_folders("k8s_provider.hcl"),
    {
      cluster-name = dependency.eks.outputs.eks_cluster_id
    }
  )
}

dependency "eks" {
  config_path = "${get_terragrunt_dir()}/../002-eks"

  mock_outputs = {
    eks_cluster_id = local.tf_vars.airwave_stack_name
  }
  mock_outputs_merge_strategy_with_state = "shallow"
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

  create_namespace = true
  namespace        = "nvidia-device-plugin"

}
