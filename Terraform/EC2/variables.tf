
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
  type        = string
  description = "The IP range you are going to connect to Hyperglance UI/API. Must be a valid ipv4 CIDR range of the form x.x.x.x/x"

  validation {
    # Validate input supplied is an IPv4 CIDR
    condition     = can(regex("(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", var.allow_https_inbound_cidr))
    error_message = "The cidr must be a valid ipv4 address range (ex: 10.0.0.0/24)."
  }
}

variable "allow_ssh_inbound_cidr" {
  type        = string
  description = "The IP range you are going to SSH to the Hyperglance Instance from. Must be a valid CIDR range of the form x.x.x.x/x"

  validation {
    # Validate input supplied is an IPv4 CIDR
    condition = can(regex("(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/(3[0-2]|[1-2][0-9]|[0-9]))$", var.allow_ssh_inbound_cidr))

    error_message = "The cidr must be a valid ipv4 address range (ex: 192.168.5.120/32)."
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
    Persistent  = "True"
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
    "us-east-1"      = "ami-0add6e9dfe8107698"
    "us-east-2"      = "ami-03a1b5a830ca5553f"
    "us-west-1"      = "ami-0f513432ac9a27cf3"
    "us-west-2"      = "ami-0798e974246b7e5fe"
    "ca-central-1"   = "ami-0d2a270122d801858"
    "eu-west-1"      = "ami-02a63d0ff098296f9"
    "eu-central-1"   = "ami-090405c5428440480"
    "eu-west-2"      = "ami-0f25d1100cd9268dd"
    "eu-west-3"      = "ami-0194292af9171ef0c"
    "eu-north-1"     = "ami-0d367829627b761fb"
    "eu-south-1"     = "ami-0c95e9c4960fecf55"
    "ap-northeast-1" = "ami-02734cc17eaff908c"
    "ap-northeast-2" = "ami-03a2f3a2a45eb1e62"
    "ap-southeast-1" = "ami-017b3526d970a919e"
    "ap-southeast-2" = "ami-011f1bc73e645e9bd"
    "ap-south-1"     = "ami-01b4f7322cb11ce76"
    "ap-east-1"      = "ami-04947aff3848657b3"
    "sa-east-1"      = "ami-0143e5b294df65d22"
    "af-south-1"     = "ami-0542e73dd06a98368"
    "me-south-1"     = "ami-0d6a13dc0b606d3e2"
    "us-gov-east-1"  = "ami-000ec92a21e1412e2"
    "us-gov-west-1"  = "ami-0c262e5f2ebc8cf05"
  }
}
