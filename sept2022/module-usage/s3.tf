module "my_bucket" {
    source = "../s3-module"
    bucket_name = "rssr-my-test-ver-bucket-09"
    versioning = {
        enabled = true
    }
}

module "my_bucket_2" {
    source = "../s3-module"
    bucket_name = "rssr-my-test-web-bucket-09"
    website = {
        index_document = "index.html"
        error_document = "error.html"
    }
}