# Create RDS serverless cluster to host Hyperglance DB
#tfsec:ignore:aws-rds-encrypt-cluster-storage-data
resource "aws_rds_cluster" "postgresql" {
  cluster_identifier = "hyperglance-rds-cluster"
  engine             = "aurora-postgresql"
  engine_mode        = "serverless"
  scaling_configuration {
    auto_pause               = false
    max_capacity             = var.rds_max_capacity
    min_capacity             = var.rds_min_capacity
    seconds_until_auto_pause = 300
    timeout_action           = "RollbackCapacityChange"
  }
  availability_zones      = data.aws_availability_zones.available.names
  master_username         = sensitive(random_string.rds-username.id)
  master_password         = sensitive(random_string.rds-password.id)
  backup_retention_period = var.rds_backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  vpc_security_group_ids  = [aws_security_group.postgresql.id]
  db_subnet_group_name    = aws_db_subnet_group.hyperglance.name
  storage_encrypted       = true
}