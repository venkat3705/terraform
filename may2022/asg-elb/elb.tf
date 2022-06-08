resource "aws_elb" "my_clb" {
  name = "my-clb"
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
  internal = false
  listener {
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }
  health_check {
    healthy_threshold   = 4
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
    target              = "HTTP:80/index.html"
  }
  security_groups = [aws_security_group.tf_clb_sg.id]
}

resource "aws_security_group" "tf_clb_sg" {
  name        = "tf-clb-sg"
  description = "Allow ssh and http"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh from VPC"
    from_port   = 8080
    to_port     = 8080
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
    Name = "tf-clb-sg"
  }

}
