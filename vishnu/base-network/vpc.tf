resource "aws_vpc" "golden_vpc" {
  cidr_block              = "10.0.0.0/16"
  enable_dns_hostnames    = true
  tags = {
    Name = "golden-vpc"
    project = "learning"
  }

}
resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-1"
    project = "learning"
  }
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.golden_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-sub-2"
    project = "learning"
  }
}

resource "aws_internet_gateway" "golden_igw" {
  vpc_id = aws_vpc.golden_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name = "public-rt"
    project = "learning"
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

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-sub-1"
    project = "learning"
  }
}

resource "aws_subnet" "private_sub_2" {
  vpc_id = aws_vpc.golden_vpc.id

  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "priavet-sub-2"
    project = "learning"
  }
}

resource "aws_route_table" "priavte_rt" {
  vpc_id = aws_vpc.golden_vpc.id

  tags = {
    Name = "priavte-rt"
    project = "learning"
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
