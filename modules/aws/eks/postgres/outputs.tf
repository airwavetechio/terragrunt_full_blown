
output "postgres_subnet_group_id" {
  value = aws_db_subnet_group.postgres_subnet_group.id
}

output "postgres_security_group" {
  value = aws_security_group.postgres.id
}

output "server_info" {
  value =  {
    for k, v in aws_db_instance.postgres_instance :
    k => {
      id   = v.id,
      name = v.id,
      fqdn = v.address,
      port = v.port,
      administrator_login = var.administrator_login
      administrator_password = var.administrator_password
      tags = var.tags
    }
  }
}

