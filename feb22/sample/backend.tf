terraform {
  backend "s3" {
    bucket  = "rssr-dev-artifacts-bucket"
    key     = "s3-multiaccoutnt"
    region  = "us-east-1"
    profile = "class-1"
  }
}