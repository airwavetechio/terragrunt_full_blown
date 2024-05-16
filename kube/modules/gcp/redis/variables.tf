variable "airwave_stack_name" {
  type = string
}

variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "redis_version" {
  type        = string
  default     = "REDIS_6_X"
  description = "Redis version. Only major version needed. Valid values: 4, 6."
}

variable "memory_size_gb" {
  type        = number
  default     = 7
  description = "Redis memory size"
}

variable "project_id" {
  type = string
}
variable "authorized_network" {
  type = string
}
