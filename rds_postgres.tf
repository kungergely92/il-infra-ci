resource "random_password" "random_password_postgres" {
  length  = 20
  special = false
}

resource "aws_db_instance" "rds_postgres" {
  identifier = var.rds_identifier
  name       = var.initial_db

  username = var.username
  password = random_password.random_password_postgres.result
  port     = 5432

  engine            = "postgres"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  max_allocated_storage = var.max_allocated_storage

  availability_zone   = var.availability_zone
  publicly_accessible = var.publicly_accessible

}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_identifier" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/identifier", var.rds_identifier)
  value = var.rds_identifier
  type  = "String"
  tags  = var.tags

  overwrite = true
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_endpoint" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/endpoint", var.rds_identifier)
  value = aws_db_instance.rds_postgres.endpoint
  type  = "String"
  tags  = var.tags

  overwrite = true
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_username" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/superuser/username", var.rds_identifier)
  value = var.username
  type  = "String"
  tags  = var.tags

  overwrite = true
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_password" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/superuser/password", var.rds_identifier)
  value = aws_db_instance.rds_postgres.password
  type  = "String"
  tags  = var.tags

  overwrite = true
}