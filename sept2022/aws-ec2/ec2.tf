resource "aws_instance" "web" {
  ami           = "ami-07ffb2f4d65357b42"
  instance_type = "t3.micro"

  key_name               = "rs-mum-9"
  subnet_id              = data.aws_subnet.demo_tf_subnet.id
  vpc_security_group_ids = [aws_security_group.demo_tf_sg.id]

  tags = {
    Name = "HelloWorld"
  }
}

data "aws_subnet" "demo_tf_subnet" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-pub-1"]
  }
}

resource "aws_security_group" "demo_tf_sg" {
  name        = "demo-tf-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = data.aws_subnet.demo_tf_subnet.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
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
    Name = "demo-tf-sg"
  }
}