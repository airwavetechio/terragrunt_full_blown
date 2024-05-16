terraform {
  required_version = ">= 1.0.9"
}

locals {
  max_temp_file_limit_flag = "2147483647"
}

resource "aws_db_instance" "postgres_instance" {
  identifier                 = var.db_name
  port                       = 5432
  allocated_storage          = var.storage_gb
  max_allocated_storage      = var.max_storage_gb
  engine                     = "postgres"
  engine_version             = var.server_version
  instance_class             = var.database_flavor[var.database_type][var.airwave_size]
  username                   = var.administrator_login
  password                   = var.administrator_password
  maintenance_window         = "Mon:04:00-Mon:04:30"
  backup_window              = "04:45-05:45"
  backup_retention_period    = var.backup_retention_days
  skip_final_snapshot        = true
  vpc_security_group_ids     = var.security_group_ids
  db_subnet_group_name       = var.subnet_group_id
  auto_minor_version_upgrade = false
  apply_immediately          = true
  parameter_group_name       = aws_db_parameter_group.airwave.id
  availability_zone          = var.zone
}

resource "aws_db_parameter_group" "airwave" {
  name   = "${var.db_name}-pg"
  family = "postgres12"

  parameter {
    name  = "temp_file_limit"
    value = local.max_temp_file_limit_flag
  }

  parameter {
    name  = "work_mem"
    value = "8192"
  }
}
