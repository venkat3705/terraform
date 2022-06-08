resource "aws_instance" "public_instance" {
  #instace_type
  instance_type        = "t2.micro"
  ami                  = "ami-0022f774911c1d690"
  security_groups      = [aws_security_group.tf_ec2_sg.id]
  subnet_id            = aws_subnet.pub_sub_1.id
  key_name             = aws_key_pair.deployer.key_name
  iam_instance_profile = aws_iam_instance_profile.tf_ec2_profile.name
  user_data            = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd.service
    sudo systemctl enable httpd.service
  EOF
  #user_data = "${file("install_apache.sh")}"
  tags = {
    Name = "tf-instance"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags, security_groups]
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

resource "aws_key_pair" "deployer" {
  key_name   = "local_key"
  public_key = tls_private_key.tf_rsa.public_key_openssh
}

resource "tls_private_key" "tf_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "local_key_priavte" {
  content  = tls_private_key.tf_rsa.private_key_pem
  filename = "local_key.pem"
}