output "server_info" {
  value = {
    for k, v in google_sql_database_instance.postgres_instance :
    k => {
      id   = v.id,
      name = v.name,
      ip   = v.ip_address.0.ip_address,
      # port = v.port,
      administrator_login    = var.administrator_login
      administrator_password = var.administrator_password
    }
  }
}
