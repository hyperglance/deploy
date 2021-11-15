# Random ID string to reduce likelihood of resource name collision
resource "random_id" "string" {
  byte_length = 5
}

# Query subnets allocated to VPC
data "aws_subnet_ids" "vpc" {
  vpc_id = var.vpc_id
}

# Output ALB DNS name
output "alb_address" {
  value = aws_lb.hyperglance.dns_name
}
output "note" {
  value = "Allow 5-10 minutes for the ECS container to become available on the ALB"
}