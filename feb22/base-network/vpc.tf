locals {
  CostCenter = "1238"
}

variable "env" {
  type = string
  description = "enter environment name"
}

variable "vpc_cidr_block" {
  type = string
  description = "Enter your VPC Range"
  default = "10.0.0.0/16"
}

resource "aws_vpc" "golden_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name       = "${var.env}-golden-vpc"
    CostCenter = local.CostCenter
  }

}
resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 0)
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.env}-pub-sub-1"
    CostCenter = local.CostCenter
  }
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.env}-pub-sub-2"
    CostCenter = local.CostCenter
  }
}

resource "aws_internet_gateway" "golden_igw" {
  vpc_id = aws_vpc.golden_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name       = "${var.env}-public-rt"
    CostCenter = local.CostCenter
  }

}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_rt.id
  gateway_id             = aws_internet_gateway.golden_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "pub_sub_1_associate" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.pub_sub_1.id

}

resource "aws_route_table_association" "pub_sub_2_associate" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.pub_sub_2.id
}

##############################################################################

resource "aws_subnet" "private_sub_1" {
  vpc_id = aws_vpc.golden_vpc.id

  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2)

  tags = {
    Name       = "${var.env}-private-sub-1"
    CostCenter = local.CostCenter
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id = aws_vpc.golden_vpc.id

  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 3)

  tags = {
    Name       = "${var.env}-priavet-sub-2"
    CostCenter = local.CostCenter
  }
}

resource "aws_route_table" "priavte_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name       = "${var.env}-priavte-rt"
    CostCenter = local.CostCenter
  }

}

resource "aws_route_table_association" "priavte_sub_1_associate" {
  route_table_id = aws_route_table.priavte_rt.id
  subnet_id      = aws_subnet.private_sub_1.id

}

resource "aws_route_table_association" "priavte_sub_2_associate" {
  route_table_id = aws_route_table.priavte_rt.id
  subnet_id      = aws_subnet.private_sub_2.id
}
