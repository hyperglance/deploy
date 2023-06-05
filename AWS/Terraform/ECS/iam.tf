# Task execution role for Hyperglance task
resource "aws_iam_role" "hg_task_execution_role" {
  name        = "Hyperglance-ECS-TaskExecution-Role-${random_string.string.id}"
  description = "Task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  path        = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

}

# Attach managed AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "hg_task_execution_role" {
  role       = aws_iam_role.hg_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task role for Hyperglance task to enable the container to auth with AWS for Hyperglance
resource "aws_iam_role" "hg_wildfly_task_role" {
  name        = "Hyperglance-Wildfly-ECS-Task-Role-${random_string.string.id}"
  description = "IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  path        = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

}

# https://support.hyperglance.com/knowledge/aws-iam-policy-requirements
# Read-Only Policy

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "hg_task_policy" {
  name        = "Hyperglance-Read-Policy-${random_string.string.id}"
  path        = "/"
  description = "Hyperglance Read Policy for task"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "access-analyzer:List*",
          "apigateway:GET",
          "autoscaling:Describe*",
          "backup:ListProtectedResources",
          "cloudwatch:Describe*",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cur:DescribeReportDefinitions",
          "dax:Describe*",
          "dax:ListTags",
          "dynamodb:Describe*",
          "dynamodb:ListTables",
          "dynamodb:ListTagsOfResource",
          "directconnect:Describe*",
          "ec2:Describe*",
          "ec2:Get*",
          "ec2:Search*",
          "ecs:Describe*",
          "ecs:List*",
          "eks:Describe*",
          "eks:List*",
          "elasticloadbalancing:Describe*",
          "iam:List*",
          "iam:Get*",
          "iam:GenerateCredentialReport",
          "lambda:List*",
          "ram:GetResourceShareAssociations",
          "redshift:Describe*",
          "redshift:List*",
          "rds:Describe*",
          "rds:ListTagsForResource",
          "route53:List*",
          "route53:Get*",
          "s3:Get*",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "sts:AssumeRole",
          "sts:GetCallerIdentity",
          "workspaces:Describe*",
          "sns:List*",
          "sns:Get*",
          "sqs:List*",
          "sqs:Get*",
          "pricing:GetProducts"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

# Attach policy to Wildfly task
resource "aws_iam_role_policy_attachment" "hg_wildfly_task_role" {
  role       = aws_iam_role.hg_wildfly_task_role.name
  policy_arn = aws_iam_policy.hg_task_policy.arn
}

# Task role for Postgresql task to enable the container to auth with EFS mount
# No explicit permissions required (contained in EFS file permissions policy), so no policy to be attached to this role
resource "aws_iam_role" "hg_postgresql_task_role" {
  name        = "Hyperglance-PostgreSQL-ECS-Task-Role-${random_string.string.id}"
  description = "IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  path        = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

# Generate EFS file permissions policy
# Enforce encryption in transit, prevent anonymous access and access to root of EFS
# Compartmentalized access to individual access points by roles
data "aws_iam_policy_document" "efs" {
  statement {
    sid    = "EFS prevent anonymous access and root access by default"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.hg_postgresql_task_role.arn, aws_iam_role.hg_wildfly_task_role.arn]
    }

    actions = [
      "elasticfilesystem:ClientWrite"
    ]

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
  statement {
    sid    = "Allow ECS task execution role access to Postgresql access point"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.hg_postgresql_task_role.arn]
    }

    actions = [
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount"
    ]

    condition {
      test     = "StringEquals"
      variable = "elasticfilesystem:AccessPointArn"
      values   = [aws_efs_access_point.postgresql.arn]
    }
  }
  statement {
    sid    = "Allow ECS task wildfly role access to Wildfly access point"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.hg_wildfly_task_role.arn]
    }

    actions = [
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount"
    ]

    condition {
      test     = "StringEquals"
      variable = "elasticfilesystem:AccessPointArn"
      values   = [aws_efs_access_point.wildfly.arn]
    }
  }
  statement {
    sid    = "Allow ECS task wildfly role access to Hyperglance access point"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.hg_wildfly_task_role.arn]
    }

    actions = [
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount"
    ]

    condition {
      test     = "StringEquals"
      variable = "elasticfilesystem:AccessPointArn"
      values   = [aws_efs_access_point.hyperglance.arn]
    }
  }
  statement {
    sid    = "EFS enforce in-transit encryption"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["*"]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
