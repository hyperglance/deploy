# Create Cloudwatch log group to store logs for Hyperglance
#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "hyperglance" {
  name              = "Hyperglance-${random_string.string.id}"
  retention_in_days = 7
}

# Provision ECS cluster with capacity providers available
resource "aws_ecs_cluster" "hyperglance" {
  name               = "Hyperglance-${random_string.string.id}"
  capacity_providers = var.provisioned_capacity_provider
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.hyperglance.name
      }
    }
  }

}

# Provision Hyperglance service
resource "aws_ecs_service" "hyperglance" {
  name                               = aws_ecs_task_definition.hyperglance.family
  cluster                            = aws_ecs_cluster.hyperglance.id
  task_definition                    = aws_ecs_task_definition.hyperglance.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0   # Allow to scale to 0 on new deployment events
  deployment_maximum_percent         = 100 # Allow only 1 instance of task running at one time
  enable_ecs_managed_tags            = true
  propagate_tags                     = "SERVICE"
  health_check_grace_period_seconds  = 300 # Allow 5 minutes grace for Wildfly container to provision - prevent premature shutdown
  capacity_provider_strategy {
    base              = 1
    capacity_provider = var.capacity_provider
    weight            = 1
  }
  # Roll back unhealthy service deployments without the need for manual intervention
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  # Deploy container in any of the subnets available in the defined VPC
  network_configuration {
    subnets          = var.subnet_ids != [""] ? var.subnet_ids : data.aws_subnet_ids.vpc.ids
    security_groups  = [aws_security_group.hyperglance.id]
    assign_public_ip = true # Required to pull images where NAT gateway doesn't exist in VPC
  }
  # Register service with target group associated with ALB
  load_balancer {
    target_group_arn = aws_lb_target_group.hyperglance.arn
    container_name   = "hyperglance"
    container_port   = 8443 # Wildfly HTTPS port
  }
  # Register container IP with Route53 for discovery
  service_registries {
    registry_arn = aws_service_discovery_service.hyperglance.arn
  }

  # Prevent premature deployment before EFS mounts are ready
  depends_on = [
    aws_efs_mount_target.hyperglance, aws_efs_file_system_policy.policy
  ]
}

# Provision Postgres service
resource "aws_ecs_service" "postgresql" {
  name                               = aws_ecs_task_definition.postgresql.family
  cluster                            = aws_ecs_cluster.hyperglance.id
  task_definition                    = aws_ecs_task_definition.postgresql.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0   # Allow to scale to 0 on new deployment events
  deployment_maximum_percent         = 100 # Allow only 1 instance of task running at one time
  enable_ecs_managed_tags            = true
  propagate_tags                     = "SERVICE"
  capacity_provider_strategy {
    base              = 1
    capacity_provider = var.capacity_provider
    weight            = 1
  }
  # Roll back unhealthy service deployments without the need for manual intervention
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  # Deploy container in any of the subnets available in the defined VPC
  network_configuration {
    subnets          = var.subnet_ids != [""] ? var.subnet_ids : data.aws_subnet_ids.vpc.ids
    security_groups  = [aws_security_group.postgresql.id]
    assign_public_ip = true # Required to pull images where NAT gateway doesn't exist in VPC
  }
  # Register container IP with Route53 for discovery
  service_registries {
    registry_arn = aws_service_discovery_service.postgresql.arn
  }

  # Prevent premature deployment before EFS mounts are ready
  depends_on = [
    aws_efs_mount_target.hyperglance, aws_efs_file_system_policy.policy
  ]
}
