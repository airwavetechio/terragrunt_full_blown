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
  default     = "GP_Gen5_8"
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 102400
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
  type        = bool
  default     = false
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
  default     = "11"
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections. Possible values are Enabled and Disabled."
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  type        = string
  default     = "TLS1_2"
  description = "Minimum SSL version allowed"
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
  type        = bool
  default     = false
}

variable "firewall_rule_prefix" {
  description = "Specifies prefix for firewall rule names."
  type        = string
  default     = "firewall-"
}

variable "firewall_rules" {
  description = "List of IPs for the inbound firewall rule(s).  This can not be used if public_network_access_enabled = false."
  type        = list
  default     = []
}

variable "vnet_rule_name_prefix" {
  description = "Specifies prefix for vnet rule names."
  type        = string
  default     = "postgresql-vnet-rule-"
}

variable "vnet_rules" {
  description = "The list of maps, describing vnet rules. Valud map items: name, subnet_id."
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "A map of tags to set on every taggable resources. Empty by default."
  type        = map(string)
  default     = {}
}

variable "postgresql_configurations" {
  description = "A map with PostgreSQL configurations to enable."
  type        = map(string)
  default     = {}
  # {
  #   "work_mem" : "8192",
  # }
}

variable "auto_grow_enabled" {
  type        = string
  default     = true
  description = "Storage auto-grow prevents your server from running out of storage and becoming read-only. Defaults to true"
}

variable "databases" {
  default = []
}

variable "name_suffix" {
  type        = string
  default     = ""
  description = "A suffix to the database name (optional)"
}

variable "private_link_subnet" {
  type        = string
  default     = null
  description = "The subnet to place the private links into"
}

# variable "all_public_ips" {
#   type        = list
#   default     = []
#   description = "A list of public IPs to be added into the DB's inbound firewall rule(s)"
# }
