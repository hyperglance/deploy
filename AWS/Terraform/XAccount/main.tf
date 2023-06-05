resource "aws_iam_role" "hg_role" {
  name = "HyperglanceReadOnly"
  path = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "${var.hyperglance_instance_role}"
        }
      }
    ]
    }
  )
  tags = var.tags
}

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "hg_policy" {
  name        = "HyperglanceReadOnlyRole"
  path        = "/"
  description = "Hyperglance policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "hg_attach" {
  role       = aws_iam_role.hg_role.name
  policy_arn = aws_iam_policy.hg_policy.arn
}

output "hyperglance_xaccount_role_arn" {
  value = aws_iam_role.hg_role.arn
}
