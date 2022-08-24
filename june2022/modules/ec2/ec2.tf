locals {
  name = "${terraform.workspace}-instance"
}

resource "aws_instance" "web_demo" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "class-3-mum"
  vpc_security_group_ids = [ aws_security_group.web_sg.id]
  availability_zone = "ap-south-1c"
  subnet_id = "subnet-0634593b63f469457"
  
  tags = {
    Name = local.name
  }
}


resource "aws_instance" "web_demo_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "class-3-mum"
  vpc_security_group_ids = [ aws_security_group.web_sg.id]
  availability_zone = "ap-south-1c"
  subnet_id = "subnet-0634593b63f469457"

  # provisioner "file" {
  #   source      = "scripts/nginx.sh"
  #   destination = "/tmp/script.sh"
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "/tmp/script.sh args",
  #   ]
  # }
  # connection {
  #   type     = "ssh"
  #   user     = "ubuntu"
  #   private_key = file("scripts/class-3-mum.pem")
  #   host     = self.public_ip
  # }

  tags = {
    Name = local.name
  }
}

resource "aws_security_group" "web_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.tf_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-web-demo-sg"
  }
  
}


data "aws_vpc" "tf_vpc" {
  tags = {
    Name = "tf_vpc"
  }
  
}