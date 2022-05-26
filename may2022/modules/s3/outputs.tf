output "bucket_name" {
    value = aws_s3_bucket.main[0].id
  
}

output "bucket_arn" {
    value = aws_s3_bucket.main[0].arn
  
}

output "bucket_website_endpoint" {
    value = aws_s3_bucket.main[0].website_endpoint
  
}