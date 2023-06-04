# https://github.com/clouddrove/terraform-aws-iam-user/blob/master/main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.74.2"
      version = "~> 4.2.0"
    }
  }
}

provider "aws" {
  region  = var.AWS_REGION
  profile = var.AWS_PROFILE

}


