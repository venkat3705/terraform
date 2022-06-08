resource "aws_launch_template" "tf_lt" {
  name = "my-tf-lt"

  image_id      = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name      = "class-2-new-1"

  vpc_security_group_ids = [aws_security_group.tf_asg_sg.id]
  user_data              = filebase64("${path.module}/script/example.sh")
}

resource "aws_security_group" "tf_asg_sg" {
  name        = "tf-asg-sg"
  description = "Allow ssh and http"
  vpc_id      = aws_vpc.main.id

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
    Name = "tf-asg-sg"
  }

}

resource "aws_autoscaling_group" "tf_demo" {
  name                = "my-tf-asg"
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  launch_template {
    name = aws_launch_template.tf_lt.name
  }
  target_group_arns = [aws_lb_target_group.test.arn]
  load_balancers = [aws_elb.my_clb.id]
}