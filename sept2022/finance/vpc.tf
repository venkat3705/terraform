module "finance_vpc" {
  source       = "../aws-vpc"
  cidr_block   = "192.168.0.0/16"
  project_name = "finance"

}