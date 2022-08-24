terraform {
  backend "s3" {
    bucket         = "rssr-tf-backend-bucket"
    key            = "ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "ec2"
    profile        = "terraform_user"
  }
}