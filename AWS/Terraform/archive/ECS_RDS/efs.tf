# Create EFS file system for task persistent storage
resource "aws_efs_file_system" "hyperglance" {
  encrypted = true
  tags = {
    "Name" = "Hyperglance"
  }
}

# Create mount target in every subnet in chosen VPC
resource "aws_efs_mount_target" "hyperglance" {
  for_each = var.subnet_ids != [""] ? var.subnet_ids : data.aws_subnet_ids.vpc.ids

  file_system_id  = aws_efs_file_system.hyperglance.id
  subnet_id       = each.key
  security_groups = [aws_security_group.efs.id]
}

# Enable backups
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.hyperglance.id

  backup_policy {
    status = "ENABLED"
  }
}

# Delay attachment of policy to allow IAM role creation to propagate
# This is to overcome an issue where the EFS file access policy complains about in invalid principal
resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_iam_role.hg_wildfly_task_role]

  create_duration = "30s"
}
resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.hyperglance.id
  policy         = data.aws_iam_policy_document.efs.json
  depends_on = [
    time_sleep.wait_30_seconds
  ]
}

# Create access point per each mount in ECS tasks definition
resource "aws_efs_access_point" "hyperglance" {
  file_system_id = aws_efs_file_system.hyperglance.id

  root_directory {
    path = "/hyperglance"
    creation_info {
      owner_gid   = 333
      owner_uid   = 333
      permissions = 0755
    }
  }

}

resource "aws_efs_access_point" "wildfly" {
  file_system_id = aws_efs_file_system.hyperglance.id

  root_directory {
    path = "/wildfly"
    creation_info {
      owner_gid   = 333
      owner_uid   = 333
      permissions = 0755
    }
  }
}
