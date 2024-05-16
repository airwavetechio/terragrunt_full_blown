output "server_info" {
  value =  {
    id   = aws_db_instance.postgres_instance.id,
    name = aws_db_instance.postgres_instance.id,
    fqdn = aws_db_instance.postgres_instance.address,
    administrator_login = var.administrator_login
    administrator_password = var.administrator_password
    tag = var.tag
  }
}