# resource "aws_iam_user" "test_users" {
#   count = length(var.user_names)

#   name = var.user_names[count.index]

#   tags = {
#     "UserNumber" = "${count.index}"
#   }
# }

# resource "aws_iam_user_policy" "test_user_policy" {
#   count = length(var.user_names)
#   name = "test"
#   user = aws_iam_user.test_users[count.index].name

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:Describe*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

variable "user_names" {
    type = list(string)
    default = [ "siva", "ram", "geetha" ]
  
}

resource "aws_iam_user" "the-accounts" {
  for_each = toset( var.user_names )
  name     = each.key
}
