variable "storage_gb" {
  description = "Max storage allowed for a server."
  type        = number
  default     = 128
}

variable "max_storage_gb" {
  description = "Max storage that server will use when autoscaled."
  type        = number
  default     = 20000
}

variable "airwave_size" {
  type        = string
  description = "The size of airwave cluster"
}

variable "database_type" {
  type        = string
  default     = "general"
  description = "Type of database"
}

variable "database_flavor" {
  type = map(any)
  default = {
    "analysis" = {
      "slow_few"      = "db.m5.xlarge"
      "moderate_solo" = "db.m5.xlarge"
      "moderate_few"  = "db.m5.xlarge"
      "fast_solo"     = "db.m5.xlarge"
    },

    "general" = {
      "slow_few"      = "db.m5.large"
      "moderate_solo" = "db.m5.large"
      "moderate_few"  = "db.m5.large"
      "fast_solo"     = "db.m5.large"
    }

    "backup" = {
      "slow_few"      = "db.m5.large"
      "moderate_solo" = "db.m5.large"
      "moderate_few"  = "db.m5.large"
      "fast_solo"     = "db.m5.large"
    }
  }
}

variable "databases" {
  default = []
  # [
  #   {
  #     "instance" = "analysis",
  #     "name"     = "analysis"
  #   },
  #   {
  #     "instance" = "general",
  #     "name"     = "core"
  #   },
  #   {
  #     "instance" = "general",
  #     "name"     = "ingest"
  #   },
  #   {
  #     "instance" = "general",
  #     "name"     = "keycloak"
  # }]
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
  type        = string
  default     = "postgres"
}

variable "administrator_password" {
  description = "The password associated with the administrator_login for the PostgreSQL Server."
  type        = string
}

variable "server_version" {
  description = "Specifies the version of PostgreSQL to use. Changing this forces a new resource to be created."
  type        = string
  default     = "12.9"
}

variable "db_name" {
  type = string
}

variable "subnet_group_id" {
  type        = string
  description = "Database subnet group Id."
}

variable "vpc_id" {
  type        = string
  description = "VPC id where compute machines will be provisioned"
}

variable "zone" {
  type        = string
  description = "Aws availability zone network will be created"
}

variable "tag" {
  type        = string
  description = "Tag which will be assigned to instance"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group ids"
}
