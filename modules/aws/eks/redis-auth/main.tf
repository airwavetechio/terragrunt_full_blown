terraform {
  required_version = ">= 1.0.9"
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.subdomain}-redis-subnet-group"
  subnet_ids = var.redis_cache_subnet_ids
}

resource "aws_security_group" "redis" {
  name        = "${var.subdomain}-redis"
  description = "Allow access to redis from vpc"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.airwave_redis_sg
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["source_port_range"]
      to_port     = ingress.value["destination_port_range"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["source_address"]]
    }
  }
}

resource "aws_elasticache_replication_group" "redis" {
  automatic_failover_enabled = false
  #preferred_cache_cluster_azs = ["us-west-2a", "us-west-2b"]
  replication_group_id       = var.subdomain
  description                = "Replication group for ${var.subdomain}"
  engine_version             = var.redis_version
  node_type                  = "cache.m5.large"
  num_cache_clusters         = 1
  parameter_group_name       = var.redis_param_group_name
  security_group_ids         = [aws_security_group.redis.id]
  subnet_group_name          = aws_elasticache_subnet_group.redis.name
  port                       = 6379
  transit_encryption_enabled = true
  #user_group_ids              = [aws_elasticache_user_group.group.user_group_id]
  auth_token = var.redis_password

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.subdomain}-cache"
  replication_group_id = aws_elasticache_replication_group.redis.id

}

# resource "aws_elasticache_user" "user" {
#   user_id       = "new-default-user"
#   user_name     = var.redis_username
#   access_string = "on ~* +@all"  
#   engine        = "REDIS"
#   passwords = var.redis_passwords

# }


# resource "aws_elasticache_user_group" "group" {
#   engine        = "REDIS"
#   user_group_id = var.subdomain
#   user_ids      = [aws_elasticache_user.user.user_id]

#   lifecycle {
#     ignore_changes = [user_ids]
#   }
# }
