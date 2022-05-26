resource "aws_instance" "public_instance" {
  #instace_type
  instance_type   = "t2.micro"
  ami             = "ami-0c4f7023847b90238"
  security_groups = [aws_security_group.tf_ec2_sg.id]
  subnet_id       = aws_subnet.pub_sub_1.id
  key_name        = "class-2-new-1"
  tags = {
    Name = "tf-instance"
  }

}

resource "aws_security_group" "tf_ec2_sg" {
  name        = "tf-ec2-sg"
  description = "Allow ssh and http"
  vpc_id      = aws_vpc.golden_vpc.id

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-ec2-sg"
  }
}


##########################--golden-vpc_private-subnet-instance--#########################

resource "aws_instance" "private_instance" {
  #instace_type
  instance_type   = "t2.micro"
  ami             = "ami-0c4f7023847b90238"
  security_groups = [aws_security_group.tf_ec2_sg.id]
  subnet_id       = aws_subnet.private_sub_1.id
  key_name        = "class-2-new-1"
  tags = {
    Name = "tf-instance-private"
  }

}

##########################--golden-vpc_private-subnet-instance--#########################

resource "aws_instance" "silver_instance" {
  #instace_type
  instance_type   = "t2.micro"
  ami             = "ami-0c4f7023847b90238"
  security_groups = [aws_security_group.silver_ec2_sg.id]
  subnet_id       = aws_subnet.silver_sub_1.id
  key_name        = "class-2-new-1"
  tags = {
    Name = "tf-instance-silver"
  }

}

resource "aws_security_group" "silver_ec2_sg" {
  name        = "silver-ec2-sg"
  description = "Allow ssh and http"
  vpc_id      = aws_vpc.silver_vpc.id

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-ec2-sg"
  }
}
