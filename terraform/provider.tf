terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.20.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = var.datadog_api_url
}
