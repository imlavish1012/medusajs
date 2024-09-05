terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }

  backend "s3" {
    bucket         = "edulearning-terraform-state-bucket"
    dynamodb_table = "edulearning-terraform-state-lock"
    key            = "edulearning/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }

  required_version = ">= 0.14.9"
}
