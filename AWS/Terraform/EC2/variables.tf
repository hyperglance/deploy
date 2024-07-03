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
			"af-south-1" = "ami-0e5fe1a2ed384918f"
			"ap-east-1" = "ami-0b8a12abb668e6611"
			"ap-northeast-1" = "ami-0321f6a9a8fe51676"
			"ap-northeast-2" = "ami-07dcbfea372a0ee42"
			"ap-northeast-3" = "ami-099dd6a6dc0a449fb"
			"ap-south-1" = "ami-0cd0649155fa80804"
			"ap-southeast-1" = "ami-0d55f14615497be0b"
			"ap-southeast-2" = "ami-0c7e87086d0fa9cb7"
			"ap-southeast-3" = "ami-0479d004cf4dd6ef8"
			"ca-central-1" = "ami-00c8bea5c03d3e009"
			"eu-central-1" = "ami-054e0054b45b566b4"
			"eu-north-1" = "ami-09284af62621e6e6a"
			"eu-south-1" = "ami-0ec0197ed7b2941c6"
			"eu-west-1" = "ami-09bb673b6795ec789"
			"eu-west-2" = "ami-016a430cc4a28b27b"
			"eu-west-3" = "ami-01b8be164aa650666"
			"me-south-1" = "ami-0bf2a27b976da777f"
			"sa-east-1" = "ami-080c39df960757a71"
			"us-east-1" = "ami-0785eee827f2fdc8f"
			"us-east-2" = "ami-0b06f997c7af03edc"
			"us-west-1" = "ami-0a937895211bb0dbe"
			"us-west-2" = "ami-090028b863225216d"
			"us-gov-east-1" = "ami-0d6818cb0eb663e32"
			"us-gov-west-1" = "ami-007f01fa43ba65100"
  }
}



