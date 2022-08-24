resource "aws_iam_user" "name" {
  count = length(var.user_names)
  name  = var.user_names[count.index]

  tags = merge(var.required_tags, var.common_tags, {
    Team    = "DevOps"
    project = "demo"
  })

}

resource "aws_iam_policy" "test_policy" {
  name = "my-tf-test-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
    Statement = [
      {
        Action = [
          "kms:*"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/learning-*"
        ]
      }
    ]
  })

}

variable "required_tags" {
  type = map(any)
  default = {
    Owner      = "terraform"
    CostCenter = 1234
    Depot      = "Cloud"
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    Organization = "rsiva-academy"
    project      = "learning"
  }

}

variable "user_names" {
  type    = list(any)
  default = ["sample-1", "sample-2", "sample-3"]

}

