locals {
  vpc = {
    availability_zones = ["a", "b", "c"]
    cidr               = "10.0.0.0/16"
    private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  }
  //  airwave_stack_name = "${basename(get_terragrunt_dir())}"
  ingress_class = "istio"
}
