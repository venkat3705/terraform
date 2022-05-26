resource "aws_instance" "web-1" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_1.id
  key_name = "share"

  tags = {
    Name = "HelloWorld-2"
  }
}

resource "aws_instance" "db" {
  ami           = "ami-0f9fc25dd2506cf6d"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_1.id
  key_name = "share"

  tags = {
    Name = "dbexample"
  }
}

