provider "aws" {
  region  = "us-east-1"
  profile = "class-1"
}

provider "aws" {
  alias   = "mumbai"
  region  = "ap-south-1"
  profile = "class-1"
}

provider "aws" {
  alias   = "second"
  region  = "ap-south-1"
  profile = "class-2"
}