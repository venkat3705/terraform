resource "aws_s3_bucket" "source_bucket" {
  bucket = "rssr-replication-source-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }

  force_destroy = true
  replication_configuration {
    role = aws_iam_role.s3_replication_role.arn
    rules {
      id     = "my-s3-replication"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.destination_bucket.arn
        storage_class = "STANDARD"
      }
    }
  }
}


resource "aws_s3_bucket" "destination_bucket" {
  bucket        = "rssr-replication-destination-bucket"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "destination_bucket_version" {
  bucket = aws_s3_bucket.destination_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_role" "s3_replication_role" {
  name               = "tf-source-dest-rep-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY  
}

resource "aws_iam_policy" "s3_replication_policy" {
  name   = "source-dest-buckets-iam-policy"
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
            "${aws_s3_bucket.source_bucket.arn}"
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
            "${aws_s3_bucket.source_bucket.arn}/*"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags"
         ],
         "Resource": [
            "${aws_s3_bucket.destination_bucket.arn}/*"
         ]
      }
   ]
}
  POLICY
}

resource "aws_iam_role_policy_attachment" "s3_replication_policy_attachment" {
  role       = aws_iam_role.s3_replication_role.name
  policy_arn = aws_iam_policy.s3_replication_policy.arn
}