locals {
  major_version = split(".", var.engine_version)[0]
}


# RDS
resource "aws_db_instance" "this" {
  identifier                 = "${var.project_name}-db"
  db_name                    = "${var.project_name}_db"
  allocated_storage          = 20
  storage_type               = "gp3"
  engine                     = "postgres"
  engine_version             = var.engine_version
  instance_class             = var.instance_type
  username                   = var.db_user
  password                   = var.db_password
  db_subnet_group_name       = aws_db_subnet_group.this.name
  parameter_group_name       = aws_db_parameter_group.this.name
  backup_retention_period    = 0
  auto_minor_version_upgrade = false
  multi_az                   = false
  skip_final_snapshot        = true
  vpc_security_group_ids     = [aws_security_group.this.id]
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.project_name}-db-parameter-group"
  family      = "postgres${local.major_version}"
  description = "Custom parameter group for ${var.project_name} RDS instance"

  parameter {
    name  = "timezone"
    value = "Asia/Tokyo"
  }
  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = "1000"
  }
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.project_name}-db-subnet-group"
  subnet_ids  = var.private_subnet_ids
  description = "subnet group for db"
}
