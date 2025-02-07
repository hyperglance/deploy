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
			"af-south-1" = "ami-0730540578a56113c"
			"ap-east-1" = "ami-07c7361438fde55fd"
			"ap-northeast-1" = "ami-050aadc1b14297509"
			"ap-northeast-2" = "ami-0fdeb9cf441e26dfe"
			"ap-northeast-3" = "ami-0ff914c9c12675613"
			"ap-south-1" = "ami-0fc0d43daa1d2c35a"
			"ap-southeast-1" = "ami-069c58bb8561b8177"
			"ap-southeast-2" = "ami-08d1e114eb518a9c1"
			"ap-southeast-3" = "ami-03f63102fd9791985"
			"ca-central-1" = "ami-07eac8207f5634808"
			"eu-central-1" = "ami-0770576f5865cd161"
			"eu-north-1" = "ami-033921401dbfcde9e"
			"eu-south-1" = "ami-00148da1750e90d7e"
			"eu-west-1" = "ami-08f3ffe44c7af2389"
			"eu-west-2" = "ami-0894664d243114959"
			"eu-west-3" = "ami-0906d75939e9b5293"
			"me-south-1" = "ami-02f11cea830985c4f"
			"sa-east-1" = "ami-05b8b71543579469a"
			"us-east-1" = "ami-0b906a70638e0384b"
			"us-east-2" = "ami-06fba98f8ea37acb1"
			"us-west-1" = "ami-03933edb3618e2ea0"
			"us-west-2" = "ami-06cd64e232cfccfdb"
			"us-gov-east-1" = "ami-0b7621f3f293e949f"
			"us-gov-west-1" = "ami-09de0f01ea81b9858"
  }
}



