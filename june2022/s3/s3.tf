locals {
  required_tags = {
    Name = var.bucket_name
    Owner = "june-batch"
    CostCenter = 1234
  }
}

resource "aws_s3_bucket" "rs_demo_bucket" {
  bucket = var.bucket_name
  acl = var.bucket_acl
  force_destroy = var.force_destroy
  dynamic "versioning" {
    for_each = length(keys(var.bucket_versioning))==0 ? [] : [var.bucket_versioning]

    content {
      enabled = lookup(versioning.value, "enabled", null)
      mfa_delete = lookup(versioning.value, "mfa_delete", null)
    }
  }

  dynamic "website" {
    for_each = length(keys(var.bucket_website)) == 0 ? [] : [var.bucket_website]

    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  tags = local.required_tags
}

resource "aws_s3_bucket_policy" "rs_demo_bucket_policy" {
  bucket = aws_s3_bucket.rs_demo_bucket.id
  policy = <<POLICY
{
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Action" : [
                "s3:Get*", 
                "s3:List*"
            ],
            "Effect" : "Allow",
            "Resource" : [
                "${aws_s3_bucket.rs_demo_bucket.arn}",
                "${aws_s3_bucket.rs_demo_bucket.arn}/*"
            ],
            "Principal" : "*"
        }
    ]
}

  POLICY
}

output "bucket_website_end_point" {
  value = aws_s3_bucket.rs_demo_bucket.website_endpoint
}

output "bucket_domain_name" {
    value = aws_s3_bucket.rs_demo_bucket.bucket_domain_name
}













# resource "aws_s3_bucket_acl" "rs_demo_bucket_acl" {
#   bucket = aws_s3_bucket.rs_demo_bucket.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_versioning" "rs_demo_bucket_versioning" {
#     bucket = aws_s3_bucket.rs_demo_bucket.id
#     versioning_configuration {
#       status = "Enabled"
#     }
# }

# resource "aws_s3_bucket_website_configuration" "name" {
#   bucket = aws_s3_bucket.rs_demo_bucket.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }
# }