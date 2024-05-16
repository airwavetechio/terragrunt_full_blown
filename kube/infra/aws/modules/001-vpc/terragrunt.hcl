# Include all settings from the root terragrunt.hcl file
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc//.?ref=v3.19.0"
}

dependency "eip" {
  config_path = "${get_terragrunt_dir()}/../000-eip"

  mock_outputs = {
    eip_ids = [
      "eipalloc-mock001",
      "eipalloc-mock002",
      "eipalloc-mock003"
    ]
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
  name       = local.tf_vars.airwave_stack_name
  aws_region = local.tf_vars.aws_region
  azs = ["${local.tf_vars.aws_region}${local.environment_vars.locals.vpc["availability_zones"][0]}",
    "${local.tf_vars.aws_region}${local.environment_vars.locals.vpc["availability_zones"][1]}",
    "${local.tf_vars.aws_region}${local.environment_vars.locals.vpc["availability_zones"][2]}",
  ]

  cidr            = local.environment_vars.locals.vpc["cidr"]
  private_subnets = local.environment_vars.locals.vpc["private_subnets"]
  public_subnets  = local.environment_vars.locals.vpc["public_subnets"]

  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  reuse_nat_ips          = true # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids    = "${dependency.eip.outputs.eip_ids}"

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.tf_vars.airwave_stack_name}" = "shared"
    "kubernetes.io/role/elb"                                    = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.tf_vars.airwave_stack_name}" = "shared"
    "kubernetes.io/role/internal-elb"                           = 1
  }


  manage_default_network_acl    = true
  default_network_acl_tags      = { Name = "${local.tf_vars.airwave_stack_name}-default" }
  manage_default_route_table    = true
  default_route_table_tags      = { Name = "${local.tf_vars.airwave_stack_name}-default" }
  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.tf_vars.airwave_stack_name}-default" }

  tags = local.tags
}
