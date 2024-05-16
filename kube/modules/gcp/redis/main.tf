resource "google_redis_instance" "cache" {
  project            = var.project_id
  name               = "${var.subdomain}-redis"
  tier               = "BASIC"
  redis_version      = var.redis_version
  memory_size_gb     = var.memory_size_gb
  authorized_network = var.authorized_network
}
