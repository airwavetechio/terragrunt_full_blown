locals {
  # has_passwords = length(module.passwords.database_user_passwords) > 0

  ##################################
  # Database
  ##################################
  # admin_user         = "airwave"
  database_instances = toset(distinct(var.databases[*].instance))
}





resource "google_sql_database_instance" "postgres_instance" {
  for_each            = local.database_instances
  project             = var.project_id
  name                = "postgres-${each.value}"
  deletion_protection = false
  database_version    = var.database_version

  settings {
    tier            = var.database_flavor[each.value][var.airwave_size]
    disk_autoresize = true

    database_flags {
      name  = "max_locks_per_transaction"
      value = "128" # integer: 10 ... 2147483647
    }

    database_flags {
      name  = "track_activity_query_size"
      value = "16384"
    }

    database_flags {
      name  = "work_mem"
      value = "8192" # uses KB and does not support units
    }

    database_flags {
      name  = "temp_file_limit"
      value = 2147483647
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }

    backup_configuration {
      enabled    = true
      start_time = "05:15"
    }

    maintenance_window {
      day  = 1
      hour = 4
    }
  }
}

# Users
resource "google_sql_user" "postgres_admin_users" {
  for_each = google_sql_database_instance.postgres_instance
  project  = var.project_id
  instance = google_sql_database_instance.postgres_instance[each.key].name
  name     = var.administrator_login
  password = var.administrator_password
}
