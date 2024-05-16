locals {
  common_vars = jsondecode(file(find_in_parent_folders("terraform.tfvars.json")))
}

generate "backend" {
  path      = "backend_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "gcs" {
    bucket         = "k8s-tfstate"
    prefix            = "${local.common_vars.airwave_stack_name}/${path_relative_to_include()}"
  }
}
EOF
}
