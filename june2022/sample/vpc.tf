resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "tf_vpc"
    owner = var.owner
  }
}

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name  = "tf-my-igw"
    owner = var.owner
  }
}

#public subnets and route tables 

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 1)
  map_public_ip_on_launch = true
  tags = {
    Name  = "tf-pub-sub-1"
    owner = var.owner
  }
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 2)
  map_public_ip_on_launch = true

  tags = {
    Name  = "tf-pub-sub-2"
    owner = var.owner
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name  = "tf-public-rt"
    owner = var.owner
  }
}

resource "aws_route_table_association" "pub_sub_1_associate" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "pub_sub_2_associate" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_gw.id
  depends_on             = [aws_route_table.pub_rt]
}

#private subnets and route tables 

resource "aws_subnet" "private_sub_1" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3)
  tags = {
    Name  = "tf-private-sub-1"
    owner = var.owner
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 4)

  tags = {
    Name  = "tf-private-sub-2"
    owner = var.owner
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name  = "tf-private-rt"
    owner = var.owner
  }
}

resource "aws_route_table_association" "private_sub_1_associate" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_sub_2_associate" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.private_rt.id
}

variable "owner" {
  type        = string
  description = "Enter owner name"
  default     = "rsiva"
}

variable "vpc_cidr_block" {
  type        = string
  description = "provide cidr block"
  default     = "10.0.0.0/16"
}
