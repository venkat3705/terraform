resource "aws_s3_bucket" "static_web_bucket" {
  bucket = "rss-tf-static-web-bucket-2"
  acl    = "public-read"
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Project = "Learning"
    Owner   = "Terraform-user"
  }
}


resource "aws_s3_bucket_public_access_block" "static_bucket_acl" {
  bucket = aws_s3_bucket.static_web_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_policy" "update_website_root_bucket_policy" {
  bucket = aws_s3_bucket.static_web_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PolicyForWebsiteEndpointsPublicContent",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.static_web_bucket.arn}/*",
        "${aws_s3_bucket.static_web_bucket.arn}"
      ]
    }
  ]
}
POLICY
}


