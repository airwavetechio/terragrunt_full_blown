variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
}

variable "server_name" {
  type        = string
  description = "Name of the Postgres server"
}

variable "postgresql_configurations" {
  description = "A map with PostgreSQL configurations to enable."
  type        = map(string)
  default     = {}
}

resource "azurerm_postgresql_configuration" "db_configs" {
  count               = length(keys(var.postgresql_configurations))
  resource_group_name = var.resource_group_name
  server_name         = var.server_name

  name  = element(keys(var.postgresql_configurations), count.index)
  value = element(values(var.postgresql_configurations), count.index)
}
