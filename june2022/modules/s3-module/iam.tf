resource "aws_iam_user" "example_users" {
  count = length(var.users)
  name  = var.users[count.index]
}

resource "aws_iam_policy_attachment" "example_users_attachement" {
  count      = length(var.users)
  name       = "policy-attachment"
  users      = [aws_iam_user.example_users[count.index].name]
  policy_arn = aws_iam_policy.demo_policy.arn

}

resource "aws_iam_policy" "demo_policy" {
  name = "my-demo-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Get*",
          "s3:List*",
        ]
        Effect   = "Allow"
        Resource = "arn:${data.aws_partition.current.id}:s3:::rssr-tf-demo-bucket-3"
      },
      {
        Action = [
          "iam:*",
        ]
        Effect   = "Allow"
        Resource = "arn:${data.aws_partition.current.id}:iam::${data.aws_caller_identity.current.account_id}:user/*"
      },
      {
        Action = [
          "kms:*",
        ]
        Effect   = "Allow"
        Resource = "arn:${data.aws_partition.current.id}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
      },
    ]
  })

}


output "print_user_names" {
  value = [for name in var.users : name]

}