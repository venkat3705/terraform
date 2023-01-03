terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "rss-sample-1"
    key    = "finance/infra"
    region = "ap-northeast-1"
#    dynamodb_table = "finance-infra"
#    profile = "rsiva"
  }
}


provider "aws" {
  region  = "ap-south-1"
#  profile = "rsiva"
}
