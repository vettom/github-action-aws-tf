terraform {
  backend "s3" {
    bucket         = "github-action-aws-tf"
    key            = "github-action-aws-tf/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "github-action-aws-tf"
    profile        = "dvettom"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}
provider "aws" {
  region  = "eu-west-1"
  profile = "dvettom"
}
