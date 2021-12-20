
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
  #use 'var.image_ids[var.region]' to grab appropriate id
  type = map(any)
  default = {
    "us-east-1" = "ami-0bb254975ef7f7dc9"
    "us-east-2" = "ami-0e1f73336ae435cc6"
    "us-west-1" = "ami-0931e78af69bd0833"
    "us-west-2" = "ami-0565dc898edf25073"
    "ca-central-1" = "ami-0a9bb2dea510ac569"
    "eu-west-1" = "ami-02e6da35fd2853b76"
    "eu-central-1" = "ami-0b5029c9dc9fffbd8"
    "eu-west-2" = "ami-05e93fab7b1b7af4e"
    "eu-west-3" = "ami-029f332f0f6a25e84"
    "eu-north-1" = "ami-00e67c882d2c290f1"
    "eu-south-1" = "ami-04801aded330658d9"
    "ap-northeast-1" = "ami-0c3ff5cd351336af0"
    "ap-northeast-2" = "ami-04622cc71a883bee2"
    "ap-southeast-1" = "ami-0608b1948a129b457"
    "ap-southeast-2" = "ami-0afb035db4a3f65de"
    "ap-south-1" = "ami-0c69f9c3e09564ee6"
    "ap-east-1" = "ami-03da5578e5ba58907"
    "sa-east-1" = "ami-0f6b8306c79baabc9"
    "af-south-1" = "ami-0da9bf146a72cbe78"
    "me-south-1" = "ami-06a0b5549353d5b63"
    "us-gov-east-1" = "ami-04da321cb755238dc"
    "us-gov-west-1" = "ami-03081104b56a7ffec"
  }
}