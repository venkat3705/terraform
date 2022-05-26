module "my-s3" {
  source        = "../modules/s3"
  bucket_name   = "rssr-module-bucket"
  acl           = "public-read"
  force_destroy = true
  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  encryption        = true
  sse_algorithm     = "aws:kms"
  kms_master_key_id = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/s3"
}

resource "aws_s3_bucket_policy" "static_bucket_policy" {
  bucket = module.my-s3.bucket_name
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
        "${module.my-s3.bucket_arn}/*",
        "${module.my-s3.bucket_arn}"
      ],
      "Principal" : "*"
    }
  ]
}
POLICY
}

module "s3-vers" {
  source        = "../modules/s3"
  bucket_name   = "rss-version-tf-example"
  force_destroy = true

  versioning = {
    enabled = "true"
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

}

module "s3-source" {
  source      = "../modules/s3"
  bucket_name = "rss-tf-source-bucket"
  force_destroy = true
  versioning = {
    enabled = "true"
  }
  acl = "private"
  replication_configuration = {
    role = aws_iam_role.module_rep_role.arn
    rules = [{
      id       = "my-tf-rep"
      status   = "Enabled"
      priority = 1
      destination = {
        bucket        = module.s3-destination.bucket_arn
        storage_class = "STANDARD"
      }
      filter = {
        prefix = ""
      }
    }]
  }
}

module "s3-destination" {
  providers = {
    aws = aws.replica
  }
  source      = "../modules/s3"
  bucket_name = "rss-tf-dest-bucket"
  versioning = {
    enabled = "true"
  }
  acl = "private"
  force_destroy = true
}

resource "aws_iam_role" "module_rep_role" {
  name               = "module-replication-role"
  assume_role_policy = <<POLICY
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":"s3.amazonaws.com"
         },
         "Action":"sts:AssumeRole"
      }
   ]
}
POLICY

}

resource "aws_iam_policy" "module_rep_role_policy" {
  name   = "module-rep-role-policy"
  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetReplicationConfiguration",
            "s3:ListBucket"
         ],
         "Resource":[
            "${module.s3-source.bucket_arn}"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging"
         ],
         "Resource":[
            "${module.s3-source.bucket_arn}/*"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags"
         ],
         "Resource":"${module.s3-destination.bucket_arn}/*"
      }
   ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "s3_replication_policy_attachment" {
  role       = aws_iam_role.module_rep_role.name
  policy_arn = aws_iam_policy.module_rep_role_policy.arn
}