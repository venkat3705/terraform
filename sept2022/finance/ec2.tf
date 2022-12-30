resource "aws_instance" "web" {
  ami           = "ami-07ffb2f4d65357b42"
  instance_type = "t3.micro"

  key_name               = "rs-mum-9"
  subnet_id              = data.aws_subnet.finance_subnet.id
  vpc_security_group_ids = [aws_security_group.finance_sg.id]

  user_data = "${file("user-data-apache.sh")}" 

  tags = {
    Name = "finance-server"
    Owner = "rsiva"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

data "aws_subnet" "finance_subnet" {
  depends_on = [
    module.finance_vpc
  ]
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-pub-1"]
  }
}

resource "aws_security_group" "finance_sg" {
  name        = "demo-tf-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = data.aws_subnet.finance_subnet.vpc_id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "for 8080"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "finance-tf-sg"
  }
}