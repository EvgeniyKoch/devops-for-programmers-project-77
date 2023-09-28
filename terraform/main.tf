terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "hex-tr-bucket"
    key            = "terraform/state"
    region         = "us-west-2"
    dynamodb_table = "hex-tr-DynamoDB"
    encrypt        = true
  }
}

provider "aws" {
  region  = "us-west-2"
}
