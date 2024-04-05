terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }

  backend "s3" {
    bucket = "sowmith-s3-dev"
    key = "sg"
    region = "us-east-1"
    dynamodb_table = "project-locking-dev"
  }

}

provider "aws" {
  region = "us-east-1"
}