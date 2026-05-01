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
    "af-south-1"     = "ami-0f5f96635e288a337"
    "ap-east-1"      = "ami-093568bcc0d0d0668"
    "ap-northeast-1" = "ami-05121881dcb4be1a7"
    "ap-northeast-2" = "ami-0efc3f79ef5e252ba"
    "ap-northeast-3" = "ami-0fb1901f11ed6333b"
    "ap-south-1"     = "ami-0d37e496b56848e24"
    "ap-south-2"     = "ami-015d4680e042c3f06"
    "ap-southeast-1" = "ami-013c48503fe35a3e2"
    "ap-southeast-2" = "ami-0e176dabf7e38bda1"
    "ap-southeast-3" = "ami-0d285e2ebb3cc1150"
    "ap-southeast-4" = "ami-08a5a312f7565127a"
    "ca-central-1"   = "ami-05077819af926089c"
    "ca-west-1"      = "ami-07a623b471b6a2e43"
    "eu-central-1"   = "ami-000a14587cfa7a503"
    "eu-central-2"   = "ami-0987cbbc2e39fc62f"
    "eu-north-1"     = "ami-0b776ed398359d99a"
    "eu-south-1"     = "ami-0974e516dac5eda28"
    "eu-south-2"     = "ami-027a57b940e6b321c"
    "eu-west-1"      = "ami-07d0fab9b1ee41aee"
    "eu-west-2"      = "ami-0547f905098e87463"
    "eu-west-3"      = "ami-0535b66b101c3b148"
    "il-central-1"   = "ami-07614b758e332ae53"
    "sa-east-1"      = "ami-006d63ef91aeef246"
    "us-east-1"      = "ami-088043b88676f8b97"
    "us-east-2"      = "ami-0bd758513d06c2fbf"
    "us-west-1"      = "ami-0e546abedd574bc1b"
    "us-west-2"      = "ami-0446fa878f9287b06"
    "us-gov-east-1"  = "ami-0ebf3572d201829f3"
    "us-gov-west-1"  = "ami-0e57f7713dd916966"
  }
}



