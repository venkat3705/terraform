terraform {
  backend "s3" {
    bucket         = "rssr-dev-artifacts-bucket"
    key            = "terraform/base-network/tf-state"
    region         = "us-east-1"
    profile        = "class-1"
    dynamodb_table = "base-vpc"
  }
}