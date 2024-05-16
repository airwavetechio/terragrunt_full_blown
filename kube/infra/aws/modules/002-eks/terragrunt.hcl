# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints.git//.?ref=v4.32.1"
}

generate "k8s_provider" {
  path      = "eks_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = templatefile(
    "${get_terragrunt_dir()}/eks_provider.hcl",
    {},
  )
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../001-vpc"

  mock_outputs = {
    vpc_id          = "vpc-mock1234"
    vpc_cidr_block  = "10.0.0.0/16"
    private_subnets = ["subnet-mock1", "subnet-mock2", "subnet-mock3"]
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

  eks_cluster_version = "1.28"

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

  tags = local.tags

  cluster_name = local.tf_vars.airwave_stack_name

  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets

  cluster_version                      = local.eks_cluster_version
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  cluster_security_group_name          = local.tf_vars.airwave_stack_name

  map_users = [
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/contractor_tony@airwave.com"
      username = "tchong"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/jenkins-deploy"
      username = "jenkins-deploy"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/robert@airwave.com"
      username = "robert"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/karthik@airwave.com"
      username = "karthik"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/brian@airwave.com"
      username = "brian"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/david@airwave.com"
      username = "david"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/felipe@airwave.com"
      username = "felipe"
    },
    {
      groups   = ["system:masters"]
      userarn  = "arn:aws:iam::781958788828:user/vlad@airwave.com"
      username = "vlad"
    }
  ]

  node_security_group_tags = {
    "kubernetes.io/cluster/${local.tf_vars.airwave_stack_name}" = "" # null or any other value other than "owned"
  }

  node_security_group_additional_rules = {
    # Extend node-to-node security group rules. Recommended and required for the Add-ons
    ingress_vpc = {
      description = "Allow all ingress from VPC CIDR block"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      cidr_blocks = [dependency.vpc.outputs.vpc_cidr_block] // [local.vpc_cidr]
    }
    egress_vpc = {
      description = "Allow all egress from VPC CIDR block"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = [dependency.vpc.outputs.vpc_cidr_block] // [local.vpc_cidr]
    }
    egress_http = {
      description = "Allow all http egress"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"] // [local.vpc_cidr]
    }
  }

  managed_node_groups = {
    ng1 = {
      node_group_name        = "managed-ondemand"
      instance_types         = [local.tf_vars.node_type]
      min_size               = 1
      max_size               = local.tf_vars.eks_num_nodes
      desired_size           = local.tf_vars.eks_num_nodes
      subnet_ids             = dependency.vpc.outputs.private_subnets
      create_launch_template = true
    }
    gpu_ng1 = {
      node_group_name = "managed-gpu-ondemand"
      instance_types  = [local.tf_vars.gpu_node_type]
      min_size        = 1
      max_size        = local.tf_vars.eks_num_gpu_nodes
      desired_size    = local.tf_vars.eks_num_gpu_nodes
      subnet_ids      = dependency.vpc.outputs.private_subnets
      # Need optimized AMIs to take advantage of GPUs
      custom_ami_id          = "ami-07478ee95cb8f147a" // old value 1.25.6 "ami-0aba6fdec9d020511" //
      create_launch_template = true

      k8s_labels = {
        "node_type" = "gpu"
      }
    }
  }

}
