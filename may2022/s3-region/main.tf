terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "class-2"
}

provider "aws" {
  alias   = "dev"
  region  = "ap-south-1"
  profile = "class-2"
}
