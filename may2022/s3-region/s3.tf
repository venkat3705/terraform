resource "aws_s3_bucket" "bucket_virginia" {
  bucket = "rssr-virginia-1"
}

resource "aws_s3_bucket" "bucket_mum" {
  provider = aws.dev
  bucket   = "rssr-mumbai-1"
}