variable "domain" {
  type        = string
  description = "The base domain for this zone"
}

variable "subdomain" {
  type        = string
  description = "The subdomain or host name"
}

variable "cname_records" {
  type = list(string)
  description = "A list of record names"
} 

variable "ttl" {
  type        = number
  default     = 300
  description = "The DNS records TTL"
}