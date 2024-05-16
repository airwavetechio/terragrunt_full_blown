variable "resource_group" {
  type        = string
  description = "Azure resource group name"
}

variable "domain" {
  type        = string
  description = "The base domain for this zone"
}

variable "subdomain" {
  type        = string
  description = "The subdomain or host name"
}

variable "record_ip" {
  type        = list(string)
  default     = ["10.0.180.17"]
  description = "A list of IPs associated with the record_name"
}

variable "ttl" {
  type        = number
  default     = 300
  description = "The DNS records TTL"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

variable "isPiensoStack" {
  type        = bool
  default     = false
  description = "Determines the creation of a domain name for the stack"
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the Private DNS Zone Virtual Network Link."
}

variable "registration_enabled" {
  type        = bool
  description = "Auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled."
  default     = true
}