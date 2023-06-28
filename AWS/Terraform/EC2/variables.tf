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
			"af-south-1" = "ami-0d7a131ee4e357726"
			"ap-east-1" = "ami-0d341d944ef7ab44d"
			"ap-northeast-1" = "ami-0eb72ee24e19335ce"
			"ap-northeast-2" = "ami-0f75b7dd5e2721524"
			"ap-northeast-3" = "ami-049b0c1f3e509289a"
			"ap-south-1" = "ami-06f5f7a28550c02bb"
			"ap-southeast-1" = "ami-06ca5bce39ce4a308"
			"ap-southeast-2" = "ami-0d86a0e7943d11305"
			"ap-southeast-3" = "ami-02d74a35ad3450f77"
			"ca-central-1" = "ami-091b48fbb48e2f275"
			"eu-central-1" = "ami-003386a0078c2b38d"
			"eu-north-1" = "ami-0f462479656499f71"
			"eu-south-1" = "ami-077615db15fe51415"
			"eu-west-1" = "ami-0e1870150988b1cae"
			"eu-west-2" = "ami-041a2511cdb3ebd8b"
			"eu-west-3" = "ami-08d68f0d15603a9b2"
			"me-south-1" = "ami-05881a3f8f064c3d4"
			"sa-east-1" = "ami-0b5d02f26f2e24cc2"
			"us-east-1" = "ami-06f9f60e580acfd63"
			"us-east-2" = "ami-01969245a292414be"
			"us-west-1" = "ami-043760e136fb6b5df"
			"us-west-2" = "ami-0294790e2f8ab878d"
			"us-gov-east-1" = "ami-0c3b5022158a99d4f"
			"us-gov-west-1" = "ami-0c5073da393f1f04f"
  }
}
