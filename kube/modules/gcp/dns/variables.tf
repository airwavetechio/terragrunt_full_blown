variable "subdomain" {
  type        = string
  description = "The subdomain or host name"
}

variable "records" {
  type        = list(string)
  description = "A list of record names"
}

variable "ttl" {
  type        = number
  default     = 300
  description = "The DNS records TTL"
}

variable "project" {
  type        = string
  description = "Project for dns service"
}

variable "dns_zone" {
  type        = string
  description = "Zone where dns will be located"
}