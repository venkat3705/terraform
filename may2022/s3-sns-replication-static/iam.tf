resource "aws_iam_user" "simple_name" {
  count = var.create_user ? 1 : 0
  name  = "some-test-user"

}

resource "aws_iam_user" "simple_name_2" {
  count = var.create_user && var.sample ? 1 : 0
  name  = "some-test-user-2"

}