locals {
  bucket_name = join("-", ["rs", var.bucket_name])
}

resource "aws_s3_bucket" "demo_bucket" {
  #bucket = "rssr-tf-demo-bucket"
  bucket        = local.bucket_name
  force_destroy = var.force_destroy
  versioning {
    enabled = var.versioning
  }

  tags = {
    Environment = var.env
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}


resource "aws_s3_bucket_policy" "demo_bucket_policy" {
  bucket = aws_s3_bucket.demo_bucket.id
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
        "${aws_s3_bucket.demo_bucket.arn}/*",
        "${aws_s3_bucket.demo_bucket.arn}"
      ],
      "Principal" : "*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_object" "index_object" {
  bucket = aws_s3_bucket.demo_bucket.id
  key = "index.html"
  source = "file/index.html"
  acl = "public-read"
  etag = filemd5("file/index.html")
  
}