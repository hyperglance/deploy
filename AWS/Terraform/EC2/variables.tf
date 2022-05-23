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
			"af-south-1" = "ami-0feef21fb4fdc0a8b"
			"ap-east-1" = "ami-042fc6c543e22d73a"
			"ap-northeast-1" = "ami-07b4ea62f2968247a"
			"ap-northeast-2" = "ami-0ed3b76bc485de2d2"
			"ap-northeast-3" = "ami-0efb8d2389c63c940"
			"ap-south-1" = "ami-03682b7079d9c0ddb"
			"ap-southeast-1" = "ami-0a78fa9224da551a1"
			"ap-southeast-2" = "ami-0683df03e5cccaf21"
			"ap-southeast-3" = "ami-033270d444d394c9c"
			"ca-central-1" = "ami-0f3f797cd5d541563"
			"eu-central-1" = "ami-039e2693475f8ef25"
			"eu-north-1" = "ami-06ff59aac8df4ef0a"
			"eu-south-1" = "ami-0ed96d4ee384483f5"
			"eu-west-1" = "ami-009db19ec5a0d8bbf"
			"eu-west-2" = "ami-04fdd0335fb157871"
			"eu-west-3" = "ami-091379530f5ef674c"
			"me-south-1" = "ami-06d144204857e509d"
			"sa-east-1" = "ami-046e41465fc35c59d"
			"us-east-1" = "ami-0bb3f28a69dda2387"
			"us-east-2" = "ami-07cccab440a3de700"
			"us-west-1" = "ami-0bad51efa2aeb2a1d"
			"us-west-2" = "ami-014353bbe0421eb3e"
			"us-gov-east-1" = "ami-070e93042d8d275b7"
			"us-gov-west-1" = "ami-08650c40d62296d45"
  }
}
