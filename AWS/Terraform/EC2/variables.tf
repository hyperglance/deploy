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
    "af-south-1"     = "ami-00a2b58ae7d0d0557"
    "ap-east-1"      = "ami-0b18de3a2b4dc0b3b"
    "ap-northeast-1" = "ami-0e6672f56948b1290"
    "ap-northeast-2" = "ami-0b4f5a0a91c471c63"
    "ap-northeast-3" = "ami-0cd8550bffa371cb3"
    "ap-south-1"     = "ami-0d464303b4f9eeda5"
    "ap-southeast-1" = "ami-0c5a832b39add313f"
    "ap-southeast-2" = "ami-0be80b28b6acf62cf"
    "ap-southeast-3" = "ami-08dff229deedcf224"
    "ca-central-1"   = "ami-046fe822c537bd4bc"
    "eu-central-1"   = "ami-0ea3e5cce17d6fbb2"
    "eu-north-1"     = "ami-07d6000b42084de36"
    "eu-south-1"     = "ami-00627a7d59e469f64"
    "eu-west-1"      = "ami-00849fb1e97ddb2cf"
    "eu-west-2"      = "ami-018c755b624685d47"
    "eu-west-3"      = "ami-0b52161ba120e3710"
    "me-south-1"     = "ami-0ea11791f79fd9e4c"
    "sa-east-1"      = "ami-04617f81144aecca6"
    "us-east-1"      = "ami-099221e0120d59d30"
    "us-east-2"      = "ami-0617f9f68493204e6"
    "us-west-1"      = "ami-0ff6a91641c3f005f"
    "us-west-2"      = "ami-0e0e55a506bcf181a"
    "us-gov-east-1"  = "ami-01a224bd59574724b"
    "us-gov-west-1"  = "ami-00a142c179b55e923"
  }
}
