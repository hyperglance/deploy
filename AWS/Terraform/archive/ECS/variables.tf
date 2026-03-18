variable "region" {
  description = "AWS region to deploy resources to"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  description = "Subnets to deploy resource to"
  default     = [""]
}

variable "provisioned_capacity_provider" {
  description = "Capacity providers available to ECS cluster"
  default     = ["FARGATE_SPOT", "FARGATE"] # FARGATE, FARGATE_SPOT or name of the EC2 capacity provider configured
}
variable "capacity_provider" {
  description = "Capacity provider strategy to assign to services"
  default     = "FARGATE" # FARGATE, FARGATE_SPOT or name of the EC2 capacity provider configured
}

variable "tags" {
  type        = map(string)
  description = "Resource Tags to Apply"
  default = {
    Description = "Resources Required by Hyperglance"
    Help        = "https://support.hyperglance.com/"
    Source      = "https://github.com/hyperglance/deploy"
  }
}

variable "postgresql_ecs_task_cpu" {
  description = "CPU constraint for PostgreSQL task"
  default     = 256
}
variable "postgresql_ecs_task_memory" {
  description = "Memory constraint for PostgreSQL task"
  default     = 1024
}

variable "hyperglance_ecs_task_cpu" {
  description = "CPU constraint for Hyperglance task"
  default     = 512
}
variable "hyperglance_ecs_task_memory" {
  description = "Memory constraint for Hyperglance task"
  default     = 4096
}

variable "hyperglance_self_signed_cert_org" {
  description = "Organization included in the self-signed certificate"
  default     = "Hyperglance"
}

variable "acm_cert_arn" {
  description = "ARN of a certificate imported into ACM to deploy against the ALB - default to self signed cert if omitted"
  default     = ""
}

variable "allow_https_inbound_cidr" {
  type        = list(string)
  description = "The IP range you are going to connect to Hyperglance UI/API. Must be a valid ipv4 CIDR range of the form x.x.x.x/x"

  validation {
    # Validate input supplied is an IPv4 CIDR
    condition     = alltrue([for ip in var.allow_https_inbound_cidr : can(regex("(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", ip))])
    error_message = "The cidr must be a valid ipv4 address range (ex: 10.0.0.0/24)."
  }
}
locals {
  postgresql_hostname = join(".", [aws_service_discovery_service.postgresql.name, aws_service_discovery_private_dns_namespace.hyperglance.name])
  MAX_HEAPSIZE        = join("", ["${var.hyperglance_ecs_task_memory - 384}", "m"])
}