variable "subdomain" {
  type        = string
  default     = "dev"
  description = "The name postfix that will be added to all resources"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "The regional location of your Azure environemnt"
}

variable "resource_group_name" {
  type        = string
  default     = "dev"
  description = "The regional location of your Azure environemnt"
}

variable "capacity" {
  type        = string
  default     = "4"
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4."
}

variable "family" {
  type        = string
  default     = "C"
  description = "The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
}

variable "sku_name" {
  type        = string
  default     = "Basic"
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}

variable "enable_non_ssl_port" {
  type        = bool
  default     = false
  description = "Enable the non-SSL port (6379) - disabled by default."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "The minimum TLS version."
}

variable "redis_version" {
  type        = number
  default     = 6
  description = "Redis version. Only major version needed. Valid values: 4, 6."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags on the resources"
}
