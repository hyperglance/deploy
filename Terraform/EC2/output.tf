output "instance_id" {
  value = aws_instance.hg_ec2.id
}

output "public_ip" {
  value = "https://${aws_instance.hg_ec2.public_ip}"
}

output "public_dns" {
  value = "https://${aws_instance.hg_ec2.public_dns}"
}

output "private_ip" {
  value = "https://${aws_instance.hg_ec2.private_ip}"
}

output "private_dns" {
  value = "https://${aws_instance.hg_ec2.private_dns}"
}

output "hyperglance_username" {
  value       = "admin"
  description = "Default login user name"
}

output "hyperglance_password" {
  value       = aws_instance.hg_ec2.id
  description = "Initial admin password"
}
