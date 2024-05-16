variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "redis_version" {
  type        = string
  default     = "6.x"
  description = "Redis version. Only major version needed. Valid values: 4, 6."
}

variable "redis_param_group_name" {
  type        = string
  default     = "default.redis6.x"
  description = "Parameter group name for redis"
}

variable "redis_cache_subnet_ids" {
  type        = list(string)
  description = "A cache subnet group is a collection of subnets that you may want to designate for your cache clusters in a VPC"
}

variable "redis_port" {
  type        = number
  description = "Port number which redis will listen for new connections"
  default     = 6379
}

variable "airwave_redis_sg" {
  type        = list(map(any))
  description = "Security group for the redis swarm masters"
  default = [
    {
      description            = "redis"
      protocol               = "Tcp"
      source_port_range      = "6379"
      destination_port_range = "6379"
      source_address         = "10.0.2.0/24"
    },
  ]
}

variable "vpc_id" {
  type        = string
  description = "VPC id where compute machines will be provisioned"
}
