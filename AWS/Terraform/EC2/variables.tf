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
    "af-south-1"     = "ami-0cf49d4f55122a299"
    "ap-east-1"      = "ami-05d235efb87d8f689"
    "ap-northeast-1" = "ami-0604334a087e6fad1"
    "ap-northeast-2" = "ami-0fcaaa2d42e7afb64"
    "ap-northeast-3" = "ami-0ca413bbe885ddaba"
    "ap-south-1"     = "ami-02cea804dfc438710"
    "ap-south-2"     = "ami-0bd16fad5b79eafbb"
    "ap-southeast-1" = "ami-0430a8205b87a6d4a"
    "ap-southeast-2" = "ami-0827870c01fec5a9a"
    "ap-southeast-3" = "ami-0180d5aff6b31cb83"
    "ap-southeast-4" = "ami-01b4841283e6bbfe1"
    "ca-central-1"   = "ami-07539abf12e20fd7a"
    "ca-west-1"      = "ami-0848f6d71b1170161"
    "eu-central-1"   = "ami-0576d703ea04c310d"
    "eu-central-2"   = "ami-073b89dc64841960f"
    "eu-north-1"     = "ami-0d7263576d18c6923"
    "eu-south-1"     = "ami-0156b173a8e5b2423"
    "eu-south-2"     = "ami-04b2cffd38d798875"
    "eu-west-1"      = "ami-0c140ce7d7650f092"
    "eu-west-2"      = "ami-049131118dc4e0047"
    "eu-west-3"      = "ami-051bdca55fa7b76ae"
    "il-central-1"   = "ami-01fe20ebf857e7977"
    "me-central-1"   = "ami-0e93260829ef9e2bb"
    "me-south-1"     = "ami-01341b32269e37121"
    "sa-east-1"      = "ami-04175e05125ec6e37"
    "us-east-1"      = "ami-095d7d8f6a71d5856"
    "us-east-2"      = "ami-0eee6541a750b34ed"
    "us-west-1"      = "ami-0ca81ba2594e41a28"
    "us-west-2"      = "ami-015c65aae6c340a7d"
    "us-gov-east-1"  = "ami-00b6e7e2f82bd7e9c"
    "us-gov-west-1"  = "ami-0de655c5301db726d"
  }
}



