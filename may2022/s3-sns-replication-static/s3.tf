resource "aws_s3_bucket" "static_web_bucket" {
  bucket = "rss-tf-static-web-bucket"
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Project = var.project
    Owner   = var.owner
  }
}

resource "aws_s3_bucket_public_access_block" "static_bucket_acl" {
  bucket = aws_s3_bucket.static_web_bucket.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}


resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.static_web_bucket.id
  policy = <<POLICY
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect" : "Allow",
      "Action" : [
        "s3:GetObject*"
      ],
      "Resource" : [
        "${aws_s3_bucket.static_web_bucket.arn}/*",
        "${aws_s3_bucket.static_web_bucket.arn}"
      ],
      "Principal" : "*"
    }
  ]
}
POLICY
}

output "s3-bucket-stati-web-site_endpoint" {
  value = aws_s3_bucket.static_web_bucket.website_endpoint

}