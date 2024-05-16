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
  zone = "us-west-2b"
  vpc_subnet = "10.0.0.0/16"
  elasticsub = "10.0.1.0/24"
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
  cidr_block        = local.elasticsub
  availability_zone = local.zone

  tags = {
    Name = "${var.random_char}-subnet"
  }
}

module "elasticsearch" {
  source = "../../"
  vpc_id = aws_vpc.vpc.id
  subdomain           = "test-${var.random_char}"
  subnet_ids           = [aws_subnet.subnet.id]
}

output "elasticsearch" {
  value = module.elasticsearch.elasticsearch_instance
}
