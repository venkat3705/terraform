data "aws_s3_bucket" "artifacts_bucket" {
  bucket = "rssr-dev-artifacts-bucket"
}

resource "aws_s3_bucket_policy" "artifacts_bucket_policy" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  policy = <<EOF
{
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Principal" : {
                "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Effect" : "Allow",
            "Action" : [
                "s3:Get*",
                "s3:put*"
            ],
            "Resource" : [
                "${data.aws_s3_bucket.artifacts_bucket.arn}",
                "${data.aws_s3_bucket.artifacts_bucket.arn}/*"
            ]
        }
    ]
}

    EOF
}

data "aws_caller_identity" "current" {

}