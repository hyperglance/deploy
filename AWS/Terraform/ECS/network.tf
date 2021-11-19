# Provision R53 private namespace for service discovery
resource "aws_service_discovery_private_dns_namespace" "hyperglance" {
  name        = "hyperglance-${random_string.string.id}"
  description = "Service discovery private namespace"
  vpc         = var.vpc_id
}

# Provision discovery service and associate R53 private namespace to allow comms between containers
resource "aws_service_discovery_service" "hyperglance" {
  name = aws_ecs_task_definition.hyperglance.family

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.hyperglance.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

}
# Provision discovery service and associate R53 private namespace to allow comms between containers

resource "aws_service_discovery_service" "postgresql" {
  name = aws_ecs_task_definition.postgresql.family

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.hyperglance.id

    dns_records {
      ttl  = 10
      type = "A"
    }
  }

}

# Allow Hyperglance container to perform DB transactions against Postgres container
resource "aws_security_group" "postgresql" {
  name        = "Hyperglance-Postgresql-${random_string.string.id}"
  description = "Allow DB traffic"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "SQL from Hyperglance"
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      security_groups  = [aws_security_group.hyperglance.id]
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Egress to allow connectivity to pull container image"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

# Allow access to Hyperglance from ALB and AWS APIs
resource "aws_security_group" "hyperglance" {
  name        = "Hyperglance-application-${random_string.string.id}"
  description = "Hyperglance traffic UI_API + comms to AWS APIs"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow access to application from ALB"
      from_port        = 8443
      to_port          = 8443
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.alb.id]
      self             = false
    }
  ]

  egress = [
    {
      description      = "Egress to allow connectivity to AWS APIs and pull container image"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

}

# Allow Hyperglance and PostgreSQL container to NFS mounts to EFS for persistent storage
resource "aws_security_group" "efs" {
  name        = "Hyperglance-EFS-${random_string.string.id}"
  description = "Allow persistent volumes for ECS using EFS"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow access EFS from ECS services"
      from_port        = 2049
      to_port          = 2049
      protocol         = "tcp"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.hyperglance.id, aws_security_group.postgresql.id]
      self             = false
    }
  ]

  egress = []
}

# Access from ALB to services and expose HTTP + HTTPS to permitted CIDRs
resource "aws_security_group" "alb" {
  name        = "Hyperglance-ALB-${random_string.string.id}"
  description = "Allow access to ALB in front of Hyperglance"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow access to HTTP for redirect"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = var.allow_https_inbound_cidr
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow access to HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = var.allow_https_inbound_cidr
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      description      = "Egress to allow connectivity to services"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}