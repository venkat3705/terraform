resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_block

  tags = {
    "Name" = "${var.project_name}-vpc"
    Env = var.env
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
    Env = var.env
  }
}

#######################--Public subnets ---############################

resource "aws_subnet" "demo_pub_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-pub-1"
    Env = var.env
  }
}

resource "aws_subnet" "demo_pub_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-pub-2"
    Env = var.env
  }
}

resource "aws_route_table" "demo_pub_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = var.igw_dest_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-rt"
    Env = var.env
  }
}

resource "aws_route_table_association" "demo_pub_rt_ass_1" {
  subnet_id      = aws_subnet.demo_pub_1.id
  route_table_id = aws_route_table.demo_pub_rt.id
}

resource "aws_route_table_association" "demo_pub_rt_ass_2" {
  subnet_id      = aws_subnet.demo_pub_2.id
  route_table_id = aws_route_table.demo_pub_rt.id
}

#######################--Private subnets ---############################

resource "aws_subnet" "demo_pri_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 3)

  tags = {
    Name = "${var.project_name}-1"
    Env = var.env
  }
}

resource "aws_subnet" "demo_pri_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, 4)

  tags = {
    Name = "${var.project_name}-2"
    Env = var.env
  }
}


resource "aws_route_table" "demo_pri_rt" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "${var.project_name}-rt"
    Env = var.env
  }
}

resource "aws_route_table_association" "demo_pri_rt_ass_1" {
  subnet_id      = aws_subnet.demo_pri_1.id
  route_table_id = aws_route_table.demo_pri_rt.id
}

resource "aws_route_table_association" "demo_pri_rt_ass_2" {
  subnet_id      = aws_subnet.demo_pri_2.id
  route_table_id = aws_route_table.demo_pri_rt.id
}

