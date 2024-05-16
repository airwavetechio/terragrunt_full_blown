output "id" {
  value       = azurerm_redis_cache.this.id
  description = "The Route ID."
}

output "hostname" {
  value       = azurerm_redis_cache.this.hostname
  description = "The Hostname of the Redis Instance"
}

output "port" {
  value       = azurerm_redis_cache.this.port
  description = "The Port of the Redis Instance"
}

output "ssl_port" {
  value       = azurerm_redis_cache.this.ssl_port
  description = "The SSL Port of the Redis Instance"
}

output "primary_access_key" {
  value       = azurerm_redis_cache.this.primary_access_key
  description = " The Primary Access Key for the Redis Instance"
}

output "primary_connection_string" {
  value       = azurerm_redis_cache.this.primary_connection_string
  description = "The primary connection string of the Redis Instance."
}
