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

resource "aws_iam_policy" "hg_task_secrets_policy" {
  name        = "Hyperglance-ECS-SecretsManager-${random_string.string.id}"
  path        = "/"
  description = "Hyperglance allow access to SecretsManager values for PostgreSQL"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "secretsmanager:GetSecretValue"
        ]
        Effect = "Allow"
        "Resource" : [
          "${aws_secretsmanager_secret.rds-postgresql-password.arn}"
        ]
      },
    ]
  })
}

# Attach managed AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "hg_task_execution_role" {
  role       = aws_iam_role.hg_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Attach managed AmazonECSTaskExecutionRolePolicy
resource "aws_iam_role_policy_attachment" "hg_task_secrets" {
  role       = aws_iam_role.hg_task_execution_role.name
  policy_arn = aws_iam_policy.hg_task_secrets_policy.arn
}

# https://support.hyperglance.com/knowledge/aws-iam-policy-requirements
# Detailed Read-Only Policy

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "hg_task_policy" {
  name        = "Hyperglance-Detailed-Read-Policy-${random_string.string.id}"
  path        = "/"
  description = "Hyperglance Detailed Read Policy for task"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "access-analyzer:ListAnalyzers",
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
          "directconnect:DescribeLags",
          "directconnect:DescribeConnections",
          "directconnect:DescribeVirtualInterfaces",
          "directconnect:DescribeDirectConnectGateways",
          "directconnect:DescribeDirectConnectGatewayAssociations",
          "ec2:Describe*",
          "ec2:GetEbsEncryptionByDefault",
          "ec2:GetTransitGatewayRouteTablePropagations",
          "ec2:SearchTransitGatewayRoutes",
          "ecs:describeClusters",
          "ecs:describeContainerInstances",
          "ecs:describeServices",
          "ecs:describeTasks",
          "ecs:listClusters",
          "ecs:listContainerInstances",
          "ecs:listServices",
          "ecs:listTasks",
          "eks:DescribeCluster",
          "eks:DescribeFargateProfile",
          "eks:DescribeUpdate",
          "eks:DescribeNodegroup",
          "eks:ListClusters",
          "eks:ListUpdates",
          "eks:ListFargateProfiles",
          "eks:ListNodegroups",
          "eks:ListTagsForResource",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:DescribeAccountLimits",
          "elasticloadbalancing:DescribeInstanceHealth",
          "elasticloadbalancing:DescribeListenerCertificates",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeSSLPolicies",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth",
          "iam:ListAttachedUserPolicies",
          "iam:ListEntitiesForPolicy",
          "iam:ListPolicies",
          "iam:ListUserPolicies",
          "iam:ListUsers",
          "iam:ListMFADevices",
          "iam:ListServerCertificates",
          "iam:ListGroupsForUser",
          "iam:ListSSHPublicKeys",
          "iam:ListAccessKeys",
          "iam:GetAccessKeyLastUsed",
          "iam:GetAccountPasswordPolicy",
          "iam:GetCredentialReport",
          "iam:GetPolicyVersion",
          "iam:GenerateCredentialReport",
          "lambda:List*",
          "ram:GetResourceShareAssociations",
          "redshift:describeClusterSubnetGroups",
          "redshift:describeClusters",
          "redshift:describeTags",
          "rds:Describe*",
          "rds:ListTagsForResource",
          "route53:ListTrafficPolicyInstances",
          "route53:ListTrafficPolicyVersions",
          "route53:ListResourceRecordSets",
          "route53:ListHostedZones",
          "route53:GetHostedZone",
          "s3:GetAccelerateConfiguration",
          "s3:GetAnalyticsConfiguration",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketLogging",
          "s3:GetBucketNotification",
          "s3:GetBucketPolicy",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketWebsite",
          "s3:GetEncryptionConfiguration",
          "s3:GetInventoryConfiguration",
          "s3:GetLifecycleConfiguration",
          "s3:GetMetricsConfiguration",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetReplicationConfiguration",
          "s3:GetObject",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "sts:AssumeRole",
          "sts:GetCallerIdentity",
          "workspaces:DescribeWorkspaces",
          "workspaces:DescribeWorkspaceDirectories",
          "workspaces:DescribeWorkspaceBundles",
          "workspaces:DescribeWorkspacesConnectionStatus",
          "sns:ListTopics",
          "sns:ListSubscriptions",
          "sns:ListTagsForResource",
          "sns:GetTopicAttributes",
          "sqs:ListQueues",
          "sqs:GetQueueAttributes",
          "sqs:ListQueueTags"
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

# Generate EFS file permissions policy
# Enforce encryption in transit, prevent anonymous access and access to root of EFS
# Compartmentalized access to individual access points by roles
data "aws_iam_policy_document" "efs" {
  statement {
    sid    = "EFS prevent anonymous access and root access by default"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.hg_wildfly_task_role.arn]
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