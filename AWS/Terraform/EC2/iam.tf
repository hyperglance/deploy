resource "aws_iam_role" "hg_role" {
  name = "Hyperglance-HGRole"
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

#tfsec:ignore:aws-iam-no-policy-wildcards
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
        Effect   = "Allow"
        Action   = "sts:AssumeRole"
        Resource = [
          "arn:*:iam::*:role/HyperglanceReadOnly",
          "arn:*:iam::*:role/HyperglanceCostBucket"
        ]
      }
    ]
  })
  tags = var.tags
}
