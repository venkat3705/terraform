resource "aws_s3_bucket" "sample_bucket" {
  bucket = var.bucket_name

  tags = {
    "Owner"      = var.owner
    "CostCenter" = 123
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  bucket = aws_s3_bucket.sample_bucket.id
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "sample_bucket_versioning" {
  bucket = aws_s3_bucket.sample_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.sample_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.sample_bucket.id
  policy = file("s3policy.json")
}
