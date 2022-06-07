module "my-vpc" {
  source         = "../base-network"
  env            = "qa"
  vpc_cidr_block = "192.168.0.0/16"
}