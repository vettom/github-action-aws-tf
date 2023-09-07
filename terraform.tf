terraform {
  backend "s3" {
    bucket         = "github-action-aws-tf"
    key            = "github-action-aws-tf.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "github-action-aws-tf"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }
  }
}
provider "aws" {
  region = "eu-west-1"
}
