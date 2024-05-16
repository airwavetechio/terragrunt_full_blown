variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 131072
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "postgres"
}

variable "administrator_password" {
  description = "The password map associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "server_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, and 10.0. Changing this forces a new resource to be created."
  type        = string
  default     = "12"
}

variable "firewall_rules" {
  description = "List of IPs for the inbound firewall rule(s).  This can not be used if public_network_access_enabled = false."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(string)
  default     = {}
}

variable "subnet_address_prefixes" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "A list of subnet address prefixes"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network you want to place this Postgres Flexible server in. "
}

variable "zone" {
  type        = string
  description = "Specifies the Availability Zone in which the PostgreSQL Flexible Server should be located."
  default     = null
}

variable "require_secure_transport_enabled" {
  type        = string
  description = "You can use OFF or ON"
  default     = "OFF"
}

variable "name" {
  type        = string
  description = "The name of the Postgres Server"
}