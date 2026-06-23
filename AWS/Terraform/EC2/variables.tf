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
    "af-south-1"     = "ami-0c89eb5c7e139197c"
    "ap-east-1"      = "ami-0889bea74c28dcdc4"
    "ap-northeast-1" = "ami-0e11291fba7537a17"
    "ap-northeast-2" = "ami-0fe087e177ab787e0"
    "ap-northeast-3" = "ami-08a956c724557e048"
    "ap-south-1"     = "ami-00059ef4215152395"
    "ap-south-2"     = "ami-0d25c83e3e7a97fb8"
    "ap-southeast-1" = "ami-04a2926bbbb96a1dc"
    "ap-southeast-2" = "ami-0b7957ceef16fc831"
    "ap-southeast-3" = "ami-08d21448d9de3999c"
    "ap-southeast-4" = "ami-07d2507ab0bbf8ed7"
    "ca-central-1"   = "ami-0560c91921614a667"
    "ca-west-1"      = "ami-00782b8cec639d393"
    "eu-central-1"   = "ami-05b0fc294c121e0a5"
    "eu-central-2"   = "ami-07686a059f8d6ee03"
    "eu-north-1"     = "ami-06a12d76f93cec0cf"
    "eu-south-1"     = "ami-09971286e52d036cb"
    "eu-south-2"     = "ami-0a6386908278685dc"
    "eu-west-1"      = "ami-0eed511460e1c2062"
    "eu-west-2"      = "ami-089a6ed517e552dd5"
    "eu-west-3"      = "ami-06d8ca485a67354bd"
    "il-central-1"   = "ami-06e2ad613e470d495"
    "sa-east-1"      = "ami-0b57cada0d6f77f40"
    "us-east-1"      = "ami-00b3ca5b5e680f012"
    "us-east-2"      = "ami-03becfcaf17d3e394"
    "us-west-1"      = "ami-0f8192db43595ba63"
    "us-west-2"      = "ami-04883fcbde43e153b"
    "us-gov-east-1"  = "ami-07ee1435d58e94e75"
    "us-gov-west-1"  = "ami-0a789588dd8b8cede"
  }
}



