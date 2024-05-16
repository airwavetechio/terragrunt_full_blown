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

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.subdomain}-cache"
  engine               = "redis"
  engine_version       = var.redis_version
  node_type            = "cache.m5.large"
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]
  num_cache_nodes      = 1
  parameter_group_name = var.redis_param_group_name
  port                 = var.redis_port
}
