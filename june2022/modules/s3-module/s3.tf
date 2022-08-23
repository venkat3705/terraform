module "demo_s3_bucket" {
  source        = "../../s3"
  bucket_name   = "rssr-tf-module-bucket-1"
  bucket_acl    = "private"
  force_destroy = true
}

resource "aws_s3_bucket" "multiple_buckets" {
  for_each = var.buckets

  bucket        = each.value
  acl           = "private"
  force_destroy = true
  tags = {
    "Owner" = "Terraform"
  }

}