variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "server_name" {
  type        = string
  description = "Name of the Postgres server"
}

variable "firewall_rules" {
  description = "List of IPs for the inbound firewall rule(s).  This can not be used if public_network_access_enabled = false."
  type        = list
  default     = []
}

variable "firewall_rule_prefix" {
  description = "Specifies prefix for firewall rule names."
  type        = string
  default     = "firewall-"
}

resource "random_string" "random" {
  count            = length(var.firewall_rules)
  length           = 4
  lower            = true
  min_lower        = 4
  special          = false
}

resource "azurerm_postgresql_firewall_rule" "firewall_rules" {
  count               = length(var.firewall_rules)
  name                = "${var.firewall_rule_prefix}nodes-${random_string.random[count.index].result}"
  resource_group_name = var.resource_group_name
  server_name         = var.server_name
  start_ip_address    = var.firewall_rules[count.index]
  end_ip_address      = var.firewall_rules[count.index]
}
