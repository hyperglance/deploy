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
			"af-south-1" = "ami-02a0b34a3b2e79d98"
			"ap-east-1" = "ami-0d65df414dd84166e"
			"ap-northeast-1" = "ami-07f1a3ff7f1836b84"
			"ap-northeast-2" = "ami-0958ce1816433d780"
			"ap-northeast-3" = "ami-082fd603a25f4f623"
			"ap-south-1" = "ami-05603fee7a86d3f7c"
			"ap-southeast-1" = "ami-0323810e5f40b69db"
			"ap-southeast-2" = "ami-0523ffe9671021e11"
			"ap-southeast-3" = "ami-0708d8faac5aa3b7c"
			"ca-central-1" = "ami-0a76de813cd2a351d"
			"eu-central-1" = "ami-00c0e87d1f797c227"
			"eu-north-1" = "ami-01f0e8dafcf9982f9"
			"eu-south-1" = "ami-034ed2ebe89889eb7"
			"eu-west-1" = "ami-0240e53c0a8904769"
			"eu-west-2" = "ami-0f959a9ece1a9687b"
			"eu-west-3" = "ami-0619c2bcc298669be"
			"me-south-1" = "ami-0e3f93b12a8182908"
			"sa-east-1" = "ami-028b11a3995b5652a"
			"us-east-1" = "ami-0daf2b9466ef0fc0a"
			"us-east-2" = "ami-065a93f9b14ba1dfc"
			"us-west-1" = "ami-0850b3f70ff76c3f0"
			"us-west-2" = "ami-02b617b3c8e3af8fd"
			"us-gov-east-1" = "ami-0f8ee676f90efd97b"
			"us-gov-west-1" = "ami-092073b4079c949b6"
  }
}



