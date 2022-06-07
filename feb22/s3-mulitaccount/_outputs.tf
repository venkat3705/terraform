output "bucket_website_endpoint" {
  value = aws_s3_bucket.demo_bucket.website_endpoint
}

output "bucket_name" {
    value = aws_s3_bucket.demo_bucket.id
}

output "bucket_arn" {
    value = aws_s3_bucket.demo_bucket.arn
}