resource "aws_vpc" "golden_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "golden-vpc"
  }

}

########################--private---#######################

resource "aws_subnet" "private_sub_1" {
  vpc_id            = aws_vpc.golden_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-sub-1"
  }

}

resource "aws_subnet" "private_sub_2" {
  vpc_id            = aws_vpc.golden_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-sub-2"
  }

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name = "private-rt"
  }

}

resource "aws_route_table_association" "private_sub_1_associtation" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_sub_2_associtation" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.private_rt.id
}

######################-public--#################################################

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-1"
  }

}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-2"
  }

}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name = "public-rt"
  }

}

resource "aws_internet_gateway" "golden_igw" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name = "golden-igw"
  }

}

resource "aws_route" "igw_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.golden_igw.id
}

resource "aws_route_table_association" "pub_sub_1_associtation" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_sub_2_associtation" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.public_rt.id
}
