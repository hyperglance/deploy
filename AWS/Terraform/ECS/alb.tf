# Provision ALB
#tfsec:ignore:aws-elbv2-alb-not-public
resource "aws_lb" "hyperglance" {
  name               = "Hyperglance-ALB-${random_string.string.id}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.subnet_ids != [""] ? var.subnet_ids : data.aws_subnet_ids.vpc.ids

  enable_deletion_protection = false
  drop_invalid_header_fields = true

}
# Provision ALB target group
resource "aws_lb_target_group" "hyperglance" {
  name        = "Hyperglance-TG-${random_string.string.id}"
  port        = 8443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path     = "/"
    protocol = "HTTPS"
    port     = 8443
    timeout  = 30
    interval = 45
  }
}
# Provision HTTP listener for redirect to HTTPS
resource "aws_lb_listener" "http_hyperglance" {
  load_balancer_arn = aws_lb.hyperglance.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
# Provision HTTPS listener for Hyperglance service
resource "aws_lb_listener" "https_hyperglance" {
  load_balancer_arn = aws_lb.hyperglance.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = var.acm_cert_arn != "" ? var.acm_cert_arn : aws_acm_certificate.hyperglance.arn
  depends_on = [
    aws_acm_certificate.hyperglance
  ]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hyperglance.arn
  }
}
