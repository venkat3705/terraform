module "my-vpc" {
  source         = "../base-network"
  vpc_cidr_block = var.vpc_cidr_block
  env            = terraform.workspace
}

variable "vpc_cidr_block" {
  type = string
  description = "provide cidr range"
}