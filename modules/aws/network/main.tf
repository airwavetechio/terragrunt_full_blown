
data "aws_availability_zones" "available" {}

resource "aws_vpc" "myvpc" {
  cidr_block = var.address_space

  tags = {
    Name = "vpc-${var.name_postfix}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "gateway-${var.name_postfix}"

  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

resource "aws_subnet" "subnet" {
  count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.address_space, 8, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "subnet-${var.name_postfix}"
  }
}

resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group-${var.name_postfix}"
  subnet_ids = aws_subnet.subnet[*].id
}

resource "aws_security_group" "postgres" {
  name        = "postgres-${var.name_postfix}"
  description = "Allow access to postgres from vpc"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.airwave_postgres_sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["source_port_range"]
      to_port     = ingress.value["destination_port_range"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["source_address"]]
    }
  }
}
