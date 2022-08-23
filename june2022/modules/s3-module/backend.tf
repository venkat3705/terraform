terraform {
  backend "s3" {
    bucket         = "rssr-tf-backend-bucket"
    key            = "s3-module/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "s3-module"
    profile        = "terraform_user"
  }
}