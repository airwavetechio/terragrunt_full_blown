variable "project_id" {
  type = string
}

# variable "db_name" {
#   type = string
# }

variable "database_version" {
  type        = string
  default     = "POSTGRES_12"
  description = "Specifies the version of PostgreSQL to use. Changing this forces a new resource to be created."
}

variable "database_flavor" {
  type = map(any)
  default = {
    "analysis" = {
      "slow_few"      = "db-custom-4-15360"
      "moderate_solo" = "db-custom-4-15360"
      "moderate_few"  = "db-custom-4-15360"
      "fast_solo"     = "db-custom-4-15360"
    },

    "general" = {
      "slow_few"      = "db-custom-2-7680"
      "moderate_solo" = "db-custom-2-7680"
      "moderate_few"  = "db-custom-2-7680"
      "fast_solo"     = "db-custom-2-7680"
    }

    "backup" = {
      "slow_few"      = "db-custom-1-3840"
      "moderate_solo" = "db-custom-1-3840"
      "moderate_few"  = "db-custom-1-3840"
      "fast_solo"     = "db-custom-1-3840"
    }
  }
}

variable "airwave_size" {
  default     = "slow_few"
  type        = string
  description = "The size of airwave cluster"
}

# variable "subnet" {
#   type        = string
#   description = "Subnet which compute instance will use"
# }

# variable "backup_retention_days" {
#   description = "Backup retention days for the server, supported values are between 7 and 35 days."
#   type        = number
#   default     = 7
# }

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "postgres"
}

variable "administrator_password" {
  description = "The password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}



# variable "tag" {
#   type = string
#   description = "Tag which will be assigned to instance"
# }

variable "databases" {
  type = list(object({
    instance = string
    name     = string
  }))
  default = [
    {
      "instance" = "analysis",
      "name"     = "analysis"
    },
    {
      "instance" = "general",
      "name"     = "core"
    },
    {
      "instance" = "general",
      "name"     = "ingest"
    },
    {
      "instance" = "general",
      "name"     = "keycloak"
    },
    {
      "instance" = "backup",
      "name"     = "backup"
    }
  ]
}

variable "authorized_network" {
  type = string
}

variable "vpc_id" {
  type = string
}
