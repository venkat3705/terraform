module "s3_bucket" {
  source      = "../s3-module"
  bucket_name = "rssr-module-test-bucket"
  acl         = "private"
  versioning  = {
    enabled = true
  }

  
  lifecycle_rule = [
    {
      id                                     = "log1"
      enabled                                = true
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        },
      ]

      noncurrent_version_expiration = {
        days = 300
      }
    }
  ]

}

module "s3_bucket-2" {
  source      = "../s3-module"
  bucket_name = "rssr-module-test-bucket-2"
  acl         = "private"
}