# resource "aws_instance" "siva_instance" {
#   ami  = lookup(var.ami_id, data.aws_region.current.name)
#   instance_type = "t2.micro" 
#   key_name = "rs-class-1"
#   subnet_id = aws_subnet.pub_sub_1.id
#   tags = {
#     Name = "siva_demo"
#   }
# }

# variable "ami_id" {
#     type = map
#     description = "provide your ami-id"
#     default = {
#         us-east-1 = "ami-0022f774911c1d690"
#         ap-south-1 = "ami-079b5e5b3971bd10d"
#     }
  
# }

# data "aws_region" "current" {}

# data "aws_caller_identity" "current" {}