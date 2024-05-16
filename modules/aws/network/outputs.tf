output "subnet_id_private_link_id" {
  value = aws_subnet.subnet[0].id
}

output "subnet_id_private_link_cidr" {
  value = aws_subnet.subnet[0].cidr_block
}

output "subnet_id_all" {
  value = aws_subnet.subnet[*].id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "postgres_subnet_group_id" {
  value = aws_db_subnet_group.postgres_subnet_group.id
}

output "postgres_security_group" {
  value = aws_security_group.postgres.id
}