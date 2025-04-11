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
			"af-south-1" = "ami-01b0ad6fd4914a692"
			"ap-east-1" = "ami-014e08fa2de6b53e2"
			"ap-northeast-1" = "ami-012137b9ad66724cb"
			"ap-northeast-2" = "ami-055a3afd59fa97cf0"
			"ap-northeast-3" = "ami-09f2fd78c9c263a17"
			"ap-south-1" = "ami-0f75b5d0045e7da8a"
      "ap-south-2" = "ami-0e7000a749eeacff5"
			"ap-southeast-1" = "ami-08562c681a07550d0"
			"ap-southeast-2" = "ami-048c31648f0d9af0d"
			"ap-southeast-3" = "ami-0b09d00af8c165ba7"
      "ap-southeast-4" = "ami-01d272cf4e15d3d1c"
			"ca-central-1" = "ami-0e723a8ff00f8aeca"
      "ca-west-1" = "ami-0998bc35d28fa6701"
			"eu-central-1" = "ami-041c652d5bee0ba0a"
      "eu-central-2" = "ami-00cf9bd0304e21c03"
			"eu-north-1" = "ami-0d8906e7e78e8e3ff"
			"eu-south-1" = "ami-030816be5c940a2c7"
      "eu-south-2" = "ami-0b0776dbbabdcf9e2"
			"eu-west-1" = "ami-0910bf685b28cc094"
			"eu-west-2" = "ami-04cb9b170a862f2f4"
			"eu-west-3" = "ami-01b567eff6a5a856c"
      "il-central-1" = "ami-0b0e77b599e85129c"
      "me-central-1" = "ami-0e3677356e18f7fbb"
			"me-south-1" = "ami-06224290351cf4509"
			"sa-east-1" = "ami-051f375e8f971cc4d"
			"us-east-1" = "ami-097abe979fbfa8d8e"
			"us-east-2" = "ami-04d8c704fe9fffea6"
			"us-west-1" = "ami-0cadcd0f030e10916"
			"us-west-2" = "ami-0d64d7e885ba55b80"
			"us-gov-east-1" = "ami-0f8ee676f90efd97b"
			"us-gov-west-1" = "ami-092073b4079c949b6"
  }
}



