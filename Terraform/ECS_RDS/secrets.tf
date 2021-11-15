resource "aws_secretsmanager_secret" "rds-postgresql-password" {
  name       = "Hyperglance-PostgreSQL-RDS-Password-${random_id.string.id}"
  description = "Hyperglance DB password"
}

resource "aws_secretsmanager_secret_version" "rds-postgresql-password" {
  secret_id     = aws_secretsmanager_secret.rds-postgresql-password.id
  secret_string = sensitive(random_string.rds-password.id)
}

resource "aws_secretsmanager_secret_policy" "rds-postgresql-password" {
  secret_arn = aws_secretsmanager_secret.rds-postgresql-password.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "GetSecretValue",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.hg_task_execution_role.arn}"
      },
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "${aws_secretsmanager_secret.rds-postgresql-password.arn}"
    }
  ]
}
POLICY
}