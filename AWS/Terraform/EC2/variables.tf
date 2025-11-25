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
			"af-south-1" = "ami-0f05c9320df42ebbc"
			"ap-east-1" = "ami-0cd2b927065a93531"
			"ap-northeast-1" = "ami-0d6f33cdef2ce148a"
			"ap-northeast-2" = "ami-088dde0bef87710e4"
			"ap-northeast-3" = "ami-0a0a5095d3cef5d00"
			"ap-south-1" = "ami-02c3d07cb75f08c03"
			"ap-southeast-1" = "ami-0ed1aebbae59a0793"
			"ap-southeast-2" = "ami-02b6e9cf48b4006a5"
			"ap-southeast-3" = "ami-0599b6ec478fd9c71"
			"ca-central-1" = "ami-0ed9f4b59c49b1463"
			"eu-central-1" = "ami-05b7821fd474a92c1"
			"eu-north-1" = "ami-063258e8dee14ab24"
			"eu-south-1" = "ami-00aaaa8e99f572138"
			"eu-west-1" = "ami-0f846b6356c670e34"
			"eu-west-2" = "ami-01a0b67e0c1bfa784"
			"eu-west-3" = "ami-0ffb19a71a7c88749"
			"me-south-1" = "ami-0d01f7184c8f71688"
			"sa-east-1" = "ami-06c08a5dd48ce9393"
			"us-east-1" = "ami-06a1bfb5a398ccfa5"
			"us-east-2" = "ami-0cffbdd37c728da12"
			"us-west-1" = "ami-0333f7ee127a0dc88"
			"us-west-2" = "ami-02ebfc3146da2b236"
			"us-gov-east-1" = "ami-0799e6bf672d8b22b"
			"us-gov-west-1" = "ami-04084b2a4c1888362"
  }
}



