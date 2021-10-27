//Hyperglance Evaluation Deployment Terraform
terraform {
  required_version = ">= 0.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}