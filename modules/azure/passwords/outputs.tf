output "postgres_admin_passwords" {
  value = tomap({
    for k, v in random_password.postgres_admin_passwords : k => v.result
  })
  sensitive   = true
  description = "Postgres Admin Passwords"
}

output "keycloak_password" {
  value       = random_password.keycloak_password.result
  sensitive   = true
  description = "Keycload Password"
}

output "airwave_realm_admin_password" {
  value       = random_password.airwave_realm_admin_password.result
  sensitive   = true
  description = "Pienso Realm Admin Password"
}

output "database_user_passwords" {
  value = tomap({
    for k, v in random_password.database_user_passwords : k => v.result
  })
  sensitive   = true
  description = "Postgres Database User Passwords"
}

output "minio_secret_key" {
  value       = random_password.minio_secret_key.result
  sensitive   = true
  description = "Minio Secret Key"
}

output "keycloak_login_server_client_secret" {
  value       = random_password.keycloak_login_server_client_secret.result
  sensitive   = true
  description = "Keycload Login Server Client Secret"
}

output "oauth2_proxy_cookie_password" {
  value       = random_password.oauth2_proxy_cookie_password.result
  sensitive   = true
  description = "OAUTH2 Proxy Cookie Password"
}
