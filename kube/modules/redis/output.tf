output "connection_url" {
  value = "redis://default:${var.redis_password}@${var.app_name}.${var.namespace}.svc.cluster.local:${local.redis_port}"
  sensitive = true
}

output "password" {
  value = var.redis_password
  sensitive = true
}

output "host" {
  value = "${var.app_name}.${var.namespace}.svc.cluster.local"
}

output "port" {
  value = local.redis_port
}

output "username" {
  value = "default"
}
