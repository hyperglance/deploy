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
			"af-south-1" = "ami-074ec3ccdcc86989a"
			"ap-east-1" = "ami-053e7f52a71bd9649"
			"ap-northeast-1" = "ami-06aecc96ac7c26619"
			"ap-northeast-2" = "ami-014064b181dd07f8e"
			"ap-northeast-3" = "ami-02b8df39d1b8e38cf"
			"ap-south-1" = "ami-0a5260cc34adbaca2"
			"ap-southeast-1" = "ami-0d9ee2eb3fda1a006"
			"ap-southeast-2" = "ami-06415c23337ddfa4e"
			"ap-southeast-3" = "ami-0112774d6e27d5c5d"
			"ca-central-1" = "ami-08c27f74dd8404259"
			"eu-central-1" = "ami-011c4f6634a6b4712"
			"eu-north-1" = "ami-03ccf6424a806bcf0"
			"eu-south-1" = "ami-0a6b03837b845e24e"
			"eu-west-1" = "ami-05ed0774cf435a6e1"
			"eu-west-2" = "ami-01d416690d3cf96ac"
			"eu-west-3" = "ami-0a7825cf81c2544ac"
			"me-south-1" = "ami-065c0a477d9b8b479"
			"sa-east-1" = "ami-00391e8402af1517e"
			"us-east-1" = "ami-0c5b3bb44eac718e4"
			"us-east-2" = "ami-0c1249266f0dd31ab"
			"us-west-1" = "ami-0fd1c1b1d410e61f2"
			"us-west-2" = "ami-0a4c89a56a15c9bde"
			"us-gov-east-1" = "ami-04da321cb755238dc"
			"us-gov-west-1" = "ami-03081104b56a7ffec"
    }
}
