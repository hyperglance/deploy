variable "region" {
  type        = string
  description = "The AWS region to deploy Hyperglance in (ex. us-east-1)"
}

variable "instance_type" {
  type        = string
  default     = "r5a.xlarge"
  description = "The EC2 instance type (default: r5a.xlarge)"
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
  description = "The subnet ID to deploy Hyperglance into"
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
			"af-south-1" = "ami-01de7c1b2dd34b4f3"
			"ap-east-1" = "ami-0cc8e5125dadab16b"
			"ap-northeast-1" = "ami-0b7df27c243d3cb2a"
			"ap-northeast-2" = "ami-097d64b8d10b45ca7"
			"ap-northeast-3" = "ami-009fac17307129b6a"
			"ap-south-1" = "ami-0703d8950918c3342"
			"ap-southeast-1" = "ami-04c23c11514e69a17"
			"ap-southeast-2" = "ami-07c8bf8768a75efaf"
			"ap-southeast-3" = "ami-091c0f57223cff389"
			"ca-central-1" = "ami-0bab25cee8075de11"
			"eu-central-1" = "ami-0b26dbbe7858dcc37"
			"eu-north-1" = "ami-08ccaca1635df036c"
			"eu-south-1" = "ami-089fbd0fbe3f636b9"
			"eu-west-1" = "ami-05b3c13d985108da4"
			"eu-west-2" = "ami-02d5ed099f70c4e54"
			"eu-west-3" = "ami-02e9acf383b1faac1"
			"me-south-1" = "ami-07eeba299b28434ab"
			"sa-east-1" = "ami-046515badec034b95"
			"us-east-1" = "ami-010999edff6e1c567"
			"us-east-2" = "ami-034418e82584dcb37"
			"us-west-1" = "ami-032f26b9578298aee"
			"us-west-2" = "ami-0db4999cf765ae1c2"
			"us-gov-east-1" = "ami-0de3de415851f126e"
			"us-gov-west-1" = "ami-03ac256c317cd9863"
  }
}



