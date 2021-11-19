# Generate private key for self-signed cert
resource "tls_private_key" "hyperglance" {
  algorithm = "RSA"
}
# Generate self-signed cert
resource "tls_self_signed_cert" "hyperglance" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.hyperglance.private_key_pem

  subject {
    common_name  = aws_lb.hyperglance.dns_name
    organization = var.hyperglance_self_signed_cert_org
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
# Import key and cert to ACM for use in ALB
resource "aws_acm_certificate" "hyperglance" {
  private_key      = tls_private_key.hyperglance.private_key_pem
  certificate_body = tls_self_signed_cert.hyperglance.cert_pem
}