variable "region" {
  type        = string
  description = "The AWS region to deploy Hyperglance in (ex. us-east-1)"
}

variable "instance_type" {
  type        = string
  default     = "t2.large"
  description = "The EC2 instance type (default: t2.large)"
}

variable "key_name" {
  type        = string
  default     = null
  description = "The name of an existing EC2 KeyPair. The Hyperglance instance will launch with this KeyPair"
}

variable "allow_https_inbound_cidr" {
  type        = list(string)
  description = "The IP range you are going to connect to Hyperglance UI/API. Must be a valid ipv4 CIDR range of the form x.x.x.x/x"

  validation {
    # Validate input supplied is an IPv4 CIDR
    condition     = alltrue([for ip in var.allow_https_inbound_cidr : can(regex("(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", ip))])
    error_message = "The cidr must be a valid ipv4 address range (ex: 10.0.0.0/24)."
  }
}

variable "allow_ssh_inbound_cidr" {
  type        = list(string)
  description = "The IP range you are going to SSH to the Hyperglance Instance from. Must be a valid CIDR range of the form x.x.x.x/x"

  validation {
    # Validate input supplied is an IPv4 CIDR
    condition     = alltrue([for ip in var.allow_ssh_inbound_cidr : can(regex("(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", ip))])
    error_message = "The cidr must be a valid ipv4 address range (ex: 10.0.0.0/24)."
  }
}

variable "assign_public_ip" {
  type = bool
  #default     = false //Note: uncommenting this will prevent it from asking for the input at runtime
  description = "Assign a Public IP? (true/false)"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID to deploy Hyperglance to. It must be in the matching VPC."
}

variable "ec2_instance_tags" {
  type        = map(string)
  description = "Custom tags to be merged with var.tags for EC2 instance"
  default = {
    "Name" = "Hyperglance"
  }
}

variable "tags" {
  type        = map(string)
  description = "Resource Tags to Apply"
  default = {
    Description = "Resources Required by Hyperglance"
    Help        = "https://support.hyperglance.com/"
    Source      = "https://github.com/hyperglance/deploy"
  }
}

# Current public AMI's published by Hyperglance

variable "image_ids" {
  # use 'var.image_ids[var.region]' to grab appropriate id
  type = map(any)
  default = {
			"af-south-1" = "ami-0a27764d896d574b6"
			"ap-east-1" = "ami-09291c47dfd998021"
			"ap-northeast-1" = "ami-04d0c1eba1917bcb9"
			"ap-northeast-2" = "ami-0fa630591de51ff37"
			"ap-northeast-3" = "ami-089263a52c1c31215"
			"ap-south-1" = "ami-0f12b4bb311acaab3"
			"ap-southeast-1" = "ami-05976262d14dd9fb2"
			"ap-southeast-2" = "ami-0fd23b90a42bb19bf"
			"ap-southeast-3" = "ami-073fce2c4b0fafc2f"
			"ca-central-1" = "ami-0db8736a8c929539b"
			"eu-central-1" = "ami-097caceba6702946e"
			"eu-north-1" = "ami-00102b20f90fad422"
			"eu-south-1" = "ami-06d91698101e57326"
			"eu-west-1" = "ami-07ad363f3f347f787"
			"eu-west-2" = "ami-0a932ae820cfd9cf1"
			"eu-west-3" = "ami-0540e7fe703ea6ae7"
			"me-south-1" = "ami-0ca1f1b8c9a5be7a8"
			"sa-east-1" = "ami-027ed8b4d63d9ff8b"
			"us-east-1" = "ami-09c170e1ebe994bab"
			"us-east-2" = "ami-08ee99bd4f97d5513"
			"us-west-1" = "ami-0d09b090ebd05840d"
			"us-west-2" = "ami-03964ad8d2b88fa37"
			"us-gov-east-1" = "ami-0a9eaa56a160fe3f0"
			"us-gov-west-1" = "ami-05d2af042e83dcffa"
  }
}
