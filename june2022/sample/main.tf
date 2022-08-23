terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


provider "aws" {
  region  = "ap-south-1"
  profile = "terraform_user"
}

provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}