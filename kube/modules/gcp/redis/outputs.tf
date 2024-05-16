output "hostname" {
  value       = google_redis_instance.cache.host
  description = "The Hostname of the Redis Instance"
}

output "port" {
  value       = google_redis_instance.cache.port
  description = "The Port of the Redis Instance"
}

output "username" {
  value       = "default"
}

