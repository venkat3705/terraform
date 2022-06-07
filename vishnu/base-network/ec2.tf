resource "aws_instance" "vishnu_instance" {
  ami  = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  key_name = "rs-class-1"

  subnet_id = aws_subnet.pub_sub_2.id

  tags = {
    Name = "vishnu_demo"
  }
}