resource "aws_iam_role" "hg_role" {
  name = "HGRole"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = var.tags
}

resource "aws_iam_policy" "hg_policy" {
  name        = "Hyperglance"
  path        = "/"
  description = "Hyperglance policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
  tags = var.tags
}
