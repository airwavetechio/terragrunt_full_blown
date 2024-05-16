variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "buckets" {
  type        = set(string)
  description = "A list of Storage Account postfix names"
}
