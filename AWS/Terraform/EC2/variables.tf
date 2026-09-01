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
  default = 50
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
    "af-south-1"     = "ami-0c98697f9b6c80440"
    "ap-east-1"      = "ami-06e87fd0b17a209d2"
    "ap-northeast-1" = "ami-0214a9831686e2942"
    "ap-northeast-2" = "ami-00b81352e4a9b3f03"
    "ap-northeast-3" = "ami-0b9007cf918531177"
    "ap-south-1"     = "ami-033d33e20c3a98ca1"
    "ap-south-2"     = "ami-0f914383a53273c32"
    "ap-southeast-1" = "ami-0235175b0f26fc082"
    "ap-southeast-2" = "ami-0894eddd25bb61d71"
    "ap-southeast-3" = "ami-022efd9755eb47d4b"
    "ap-southeast-4" = "ami-0fff3c79ac026f8ad"
    "ca-central-1"   = "ami-0fa8ac84797db542c"
    "ca-west-1"      = "ami-0a3aef5156ed27dda"
    "eu-central-1"   = "ami-06f1b19b10935e666"
    "eu-central-2"   = "ami-0133db0ea1b6a6966"
    "eu-north-1"     = "ami-04b5694cc1a87f722"
    "eu-south-1"     = "ami-0edbc8b45a961263b"
    "eu-south-2"     = "ami-0ccc44ba01f4f0f43"
    "eu-west-1"      = "ami-063019bdac25d16b9"
    "eu-west-2"      = "ami-09c22cc05400b360a"
    "eu-west-3"      = "ami-02419363c88e00dbf"
    "il-central-1"   = "ami-0ff5437c39bbd0f13"
    "sa-east-1"      = "ami-0039d9f43a5274a09"
    "us-east-1"      = "ami-0b0142395eaa31189"
    "us-east-2"      = "ami-09310207000cc13fa"
    "us-west-1"      = "ami-0afe921e88bffa676"
    "us-west-2"      = "ami-08d08a040bff8ee0b"
    "us-gov-east-1"  = "ami-077235aff47873102"
    "us-gov-west-1"  = "ami-07b81ba78b872e30c"
  }
}



