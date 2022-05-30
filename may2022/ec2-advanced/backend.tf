terraform {
  backend "s3" {
    bucket = "rssr-class-tf"
    key    = "may2022/ec2-advanced/terraform.tfstate"
    region = "us-east-1"
    profile = "class-2"
  }
}
