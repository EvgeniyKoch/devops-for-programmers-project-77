terraform {
  backend "s3" {
    bucket         = "hex-tr-bucket"
    key            = "terraform/state"
    region         = "us-west-2"
    dynamodb_table = "hex-tr-DynamoDB"
    encrypt        = true
  }
}
