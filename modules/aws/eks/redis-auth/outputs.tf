output "hostname" {
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
  description = "The Hostname of the Redis Instance"
}

output "port" {
  value       = aws_elasticache_cluster.redis.cache_nodes[0].port
  description = "The Port of the Redis Instance"
}

output "primary_hostname" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}