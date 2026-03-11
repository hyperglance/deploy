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
    "af-south-1"     = "ami-05f0d0afdb9180b12"
    "ap-east-1"      = "ami-0abd0493a21dd874b"
    "ap-northeast-1" = "ami-0f3d44276659d907e"
    "ap-northeast-2" = "ami-05ed3c55225bbb171"
    "ap-northeast-3" = "ami-0bba58149937b762f"
    "ap-south-1"     = "ami-03adabdae7dabf1cc"
    "ap-south-2"     = "ami-02aabc4940ed475cd"
    "ap-southeast-1" = "ami-09a50a14bea5d98b4"
    "ap-southeast-2" = "ami-0b6227848d06ed9b7"
    "ap-southeast-3" = "ami-0a1eee5cfcbb88c67"
    "ap-southeast-4" = "ami-093146d575583efad"
    "ca-central-1"   = "ami-04bbb4ea468202839"
    "ca-west-1"      = "ami-09112f0ab1baa592c"
    "eu-central-1"   = "ami-0e3e14db1a6f9281c"
    "eu-central-2"   = "ami-02e2b15ec6326264f"
    "eu-north-1"     = "ami-00fa4d5f1f562c38a"
    "eu-south-1"     = "ami-0ae89a891bd35d032"
    "eu-south-2"     = "ami-0bce6e1e85eae2501"
    "eu-west-1"      = "ami-04bdb4248698ec982"
    "eu-west-2"      = "ami-0296a160bd2e53d75"
    "eu-west-3"      = "ami-07fcfdb3ed4a0158b"
    "il-central-1"   = "ami-09a560abf66a308dd"
    "me-south-1"     = "ami-0937ff1b3e21339f5"
    "sa-east-1"      = "ami-0146ddc57cf789072"
    "us-east-1"      = "ami-040830e8f5aaf2862"
    "us-east-2"      = "ami-0c97802a2f3a89445"
    "us-west-1"      = "ami-09cbceef668f72fac"
    "us-west-2"      = "ami-0b85bc9b77bf8c64a"
    "us-gov-east-1"  = "ami-09d71ae20c6e145c4"
    "us-gov-west-1"  = "ami-06e027991cfe6c2ba"
  }
}



