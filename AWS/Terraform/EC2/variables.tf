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

variable "root_volume_size" {
  type        = number
  description = "The size of the root volume"
  default = 30
}

variable "data_volume_size" {
  type        = number
  description = "The size of the data volume"
  default = 30
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
			"af-south-1" = "ami-0408d7f31246ae730"
			"ap-east-1" = "ami-03d99a9dbf439c067"
			"ap-northeast-1" = "ami-0f3f5309e2e348024"
			"ap-northeast-2" = "ami-05dc8175e8659213d"
			"ap-northeast-3" = "ami-00cedbe44e77a6ebb"
			"ap-south-1" = "ami-09ce207ecb19ebd6b"
			"ap-southeast-1" = "ami-08942c8c2141a462a"
			"ap-southeast-2" = "ami-027f37aa6b38b392a"
			"ap-southeast-3" = "ami-0ab5e7f100ce4e4c6"
			"ca-central-1" = "ami-089f86654452e24a7"
			"eu-central-1" = "ami-060a60ef114e277cf"
			"eu-north-1" = "ami-0343e1d6f5c38c8e5"
			"eu-south-1" = "ami-08ab6d30e453c905e"
			"eu-west-1" = "ami-0ab50818115be3fa6"
			"eu-west-2" = "ami-09b541a0c048b9711"
			"eu-west-3" = "ami-08a9d136ae67c7652"
			"me-south-1" = "ami-050225090a851c7e1"
			"sa-east-1" = "ami-090d57eccaddab08d"
			"us-east-1" = "ami-09c6bdfcd183ec417"
			"us-east-2" = "ami-0eece04e116429c4e"
			"us-west-1" = "ami-0fd0c6e7532b76d8b"
			"us-west-2" = "ami-0781a2341b75d73d3"
			"us-gov-east-1" = "ami-0a45c9af885e6cd04"
			"us-gov-west-1" = "ami-04f985e95a5350b39"
  }
}



