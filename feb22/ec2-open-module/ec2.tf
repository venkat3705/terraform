module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "modul-test-instance"

  ami                    = "ami-0022f774911c1d690"
  instance_type          = "t2.micro"
  key_name               = "rs-class-1"
  vpc_security_group_ids = ["sg-0db5dd810af02f650"]
  subnet_id              = "subnet-015da47b97f98db18"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}