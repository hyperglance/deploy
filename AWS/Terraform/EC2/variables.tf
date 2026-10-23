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
    "af-south-1"     = "ami-0b0c0de1245b3cbf1"
    "ap-east-1"      = "ami-07d8be512ac83c0a6"
    "ap-northeast-1" = "ami-02a26e5ab67d080b6"
    "ap-northeast-2" = "ami-0b30d116f9489517b"
    "ap-northeast-3" = "ami-07da506d0dfae26fc"
    "ap-south-1"     = "ami-068bfc5b4010cf0ae"
    "ap-south-2"     = "ami-07ab75a1179ede146"
    "ap-southeast-1" = "ami-000ac65fc65be26f6"
    "ap-southeast-2" = "ami-05cb23512139d2d7d"
    "ap-southeast-3" = "ami-02e23c86fc97ad90a"
    "ap-southeast-4" = "ami-0f6d46211517263fd"
    "ca-central-1"   = "ami-0fe4ab1d6eff9af0f"
    "ca-west-1"      = "ami-059e81f36ab98bce9"
    "eu-central-1"   = "ami-0dcbdd3f617b15cfc"
    "eu-central-2"   = "ami-04ad60f01e7a67298"
    "eu-north-1"     = "ami-0477ed4780686a99a"
    "eu-south-1"     = "ami-0f48bf139e13116f8"
    "eu-south-2"     = "ami-036a2643af5c1ffec"
    "eu-west-1"      = "ami-0fdc4e9b0d6e9c988"
    "eu-west-2"      = "ami-02e88c5ebbeb5d61e"
    "eu-west-3"      = "ami-02239551e3b0e4068"
    "il-central-1"   = "ami-0a4d6d5dedbd68c69"
    "me-central-1"   = "ami-08eee37f7bbd56521"
    "sa-east-1"      = "ami-040bee89511377208"
    "us-east-1"      = "ami-0a07c2e0888a24c41"
    "us-east-2"      = "ami-06ad7764031512158"
    "us-west-1"      = "ami-0f7ce683c8de0c6fa"
    "us-west-2"      = "ami-0638aeb635c1ba54e"
    "us-gov-east-1"  = "ami-061826f8924b6c522"
    "us-gov-west-1"  = "ami-0aac538548870fd2e"
  }
}



