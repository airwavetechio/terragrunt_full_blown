variable "random_char" {
  type        = string
  description = "Ramdom char to make the followin resources unique"
}

terraform {
  required_version = ">= 1.0.9"
  required_providers {
    aws = {
      version = "~>4.0.0"
    }
  }
}

locals {
  zone       = "us-west-2b"
  vpc_subnet = "10.0.0.0/16"
}

provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      "unit-test" : "true",
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_subnet

  tags = {
    Name = "${var.random_char}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.vpc_subnet, 8, 2)
  availability_zone = local.zone

  tags = {
    Name = "${var.random_char}-subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.random_char}-gateway"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

module "instances" {
  source                         = "../../"
  subdomain                      = "basic-${var.random_char}"
  subnet_id                      = aws_subnet.subnet.id
  vpc_id                         = aws_vpc.vpc.id
  airwave_size                   = "slow_few"
  docker_swarm_master_public_key = file("./files/id_rsa.pub")
  docker_swarm_worker_public_key = file("./files/id_rsa.pub")
  zone                           = local.zone
  is_suspended                   = false
}

output "docker_swarm_masters_all" {
  value = module.instances.docker_swarm_masters_all
}

output "docker_swarm_workers_all" {
  value = module.instances.docker_swarm_workers_all
}
