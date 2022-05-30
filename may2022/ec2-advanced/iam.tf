
resource "aws_iam_role" "ec2_role" {
  name = "my-tf-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "ec2-s3-policy"
  description = "My test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "iam:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_s3_policy_attachment" {
  name       = "ec2_s3_policy_attachment"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_instance_profile" "tf_ec2_profile" {
  name = "ec2-s3-tf-instance-profile"
  role = aws_iam_role.ec2_role.name
}