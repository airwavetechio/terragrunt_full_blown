variable "name_postfix" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "location" {
  description = "The Azure Region to deploy resources to"
  type        = string
  default     = "East US"
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Address CIDR for the network"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}

# Setting to null will set it to use the Azure default DNS servers
variable "dns_servers" {
  type    = list(string)
  default = null
  # default     = ["10.0.0.4", "10.0.0.5"]
  description = "DNS Servers for the network"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "A list of subnet address prefixes"
}

variable "subnet_address_prefix_private_link" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "A list of subnet address prefixes for the private link subnet"
}
