resource "aws_s3_bucket" "demo_bucket" {
  bucket = "rssr-tf-demo-bucket"
}

resource "aws_s3_bucket" "demo_bucket_2" {
  bucket   = "rssr-tf-demo-bucket-2"
  provider = aws.mumbai
}

resource "aws_s3_bucket" "demo_bucket_3" {
  bucket   = "rssr-tf-demo-bucket-3"
  provider = aws.second

  tags = {
    Owner = "terraform"
  }
}
