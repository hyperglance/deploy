# Provision the Hyperglance instance
resource "aws_instance" "hg_ec2" {
  ami                  = var.image_ids[var.region]
  instance_type        = var.instance_type
  key_name             = var.key_name
  availability_zone    = data.aws_subnet.hg_subnet.availability_zone
  iam_instance_profile = aws_iam_instance_profile.hg_profile.name

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.hg_sg.id]
  associate_public_ip_address = var.assign_public_ip
  root_block_device {
    volume_size = "20"
    volume_type = "gp2"
    encrypted = true
  }
  ebs_block_device {

    device_name = "/dev/sdc"
    volume_size = "20"
    volume_type = "gp2"
    encrypted = true
    delete_on_termination = false
  }
  metadata_options {
    http_endpoint = "enabled"
  }

  tags = merge(var.tags, var.ec2_instance_tags)

  lifecycle {
    ignore_changes = [
      # Prevent replacement on every apply
      ebs_block_device
    ]
  }
}

resource "aws_security_group" "hg_sg" {
  name        = "HgSecurityGroup"
  description = "Hyperglance"
  vpc_id      = data.aws_subnet.hg_subnet.vpc_id

  ingress {
    description = "TLS for UI/API"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allow_https_inbound_cidr
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh_inbound_cidr
  }

  egress {

    description      = "Allow EC2 access to internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:aws-vpc-no-public-egress-sgr
  }

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "hg_attach" {
  role       = aws_iam_role.hg_role.name
  policy_arn = aws_iam_policy.hg_policy.arn
}

resource "aws_iam_instance_profile" "hg_profile" {
  name = "HGInstanceProfile"
  role = aws_iam_role.hg_role.name
  tags = var.tags
}
data "aws_subnet" "hg_subnet" {
  id = var.subnet_id
}

