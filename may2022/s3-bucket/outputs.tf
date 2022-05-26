output "s3-bucket-website-endpoint" {
  value = module.my-s3.bucket_website_endpoint

}

output "region" {
  value = data.aws_region.current.name

}