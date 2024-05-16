resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group-${var.subdomain}"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "postgres" {
  name        = "postgres-${var.subdomain}"
  description = "Allow access to postgres from vpc"
  vpc_id      = var.vpc_id

  # dynamic "ingress" {
  #   for_each = var.source_address
  #   content {
  #     description = "postgres"
  #     from_port   = 5432
  #     to_port     = 5432
  #     protocol    = "tcp"
  #     cidr_blocks = each.value
  #   }
  # }

  ingress {
    description = "postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.source_address
  }

  tags = var.tags
}



resource "aws_db_instance" "postgres_instance" {
  for_each                   = var.databases
  identifier                 = "${var.subdomain}-postgres-${each.value}"
  port                       = 5432
  allocated_storage          = var.storage_gb
  max_allocated_storage      = var.max_storage_gb
  engine                     = "postgres"
  engine_version             = var.server_version
  instance_class             = var.database_flavor[each.value][var.airwave_size]
  username                   = var.administrator_login
  password                   = var.administrator_password
  maintenance_window         = "Mon:04:00-Mon:04:30"
  backup_window              = "04:45-05:45"
  backup_retention_period    = var.backup_retention_days
  skip_final_snapshot        = true
  vpc_security_group_ids     = [aws_security_group.postgres.id]
  db_subnet_group_name       = aws_db_subnet_group.postgres_subnet_group.id
  auto_minor_version_upgrade = false
  apply_immediately          = true
  parameter_group_name       = aws_db_parameter_group.airwave.id
  availability_zone          = var.zone
  tags                       = var.tags
}

resource "aws_db_parameter_group" "airwave" {
  name   = var.subdomain
  family = "postgres12"

  parameter {
    name  = "temp_file_limit"
    value = "2147483647"
  }

  parameter {
    name  = "work_mem"
    value = "8192"
  }
}
