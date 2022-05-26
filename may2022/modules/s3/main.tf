resource "aws_s3_bucket" "main" {
  count  = var.create_bucket ? 1:0
  bucket = var.bucket_name
  acl    = var.acl
  force_destroy = var.force_destroy
  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "versioning" {
    for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]

    content {
      enabled    = lookup(versioning.value, "enabled", null)
      mfa_delete = lookup(versioning.value, "mfa_delete", null)
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = length(keys(var.server_side_encryption_configuration)) == 0 ? [] : [var.server_side_encryption_configuration]

    content{
      dynamic "rule" {
        for_each = length(keys(lookup(server_side_encryption_configuration.value, "rule", {}))) == 0 ? [] : [lookup(server_side_encryption_configuration.value, "rule", {})]

        content {
          bucket_key_enabled = lookup(rule.value, "bucket_key_enabled", null)

          dynamic "apply_server_side_encryption_by_default" {
            for_each = length(keys(lookup(rule.value, "apply_server_side_encryption_by_default", {}))) ==0 ? [] : [lookup(rule.value, "apply_server_side_encryption_by_default", {})]

            content{
              sse_algorithm = lookup(apply_server_side_encryption_by_default.value, "sse_algorithm", null)
              kms_master_key_id = lookup(apply_server_side_encryption_by_default.value, "kms_master_key_id", null)
            }
          }
        }
      }
    }
  }

  dynamic "logging" {
    for_each = length(keys(var.logging))==0? []:[var.logging]

    content {
      target_bucket = lookup(logging.value, "target_bucket", null)
      target_prefix = lookup(logging.value, "target_prefix", null)
    }
  }

  dynamic "replication_configuration" {
    for_each = length(keys(var.replication_configuration)) == 0 ? [] : [var.replication_configuration]

    content{
      role = replication_configuration.value.role
      dynamic "rules"{
        for_each = replication_configuration.value.rules

        content {
          id                               = lookup(rules.value, "id", null)
          priority                         = lookup(rules.value, "priority", null)
          prefix                           = lookup(rules.value, "prefix", null)
          delete_marker_replication_status = lookup(rules.value, "delete_marker_replication_status", null)
          status                           = rules.value.status

          dynamic "destination" {
            for_each = length(keys(lookup(rules.value, "destination", {}))) == 0 ? [] : [lookup(rules.value, "destination", {})]

            content {
              bucket             = destination.value.bucket
              storage_class      = lookup(destination.value, "storage_class", null)
              replica_kms_key_id = lookup(destination.value, "replica_kms_key_id", null)
              account_id         = lookup(destination.value, "account_id", null)

              dynamic "access_control_translation" {
                for_each = length(keys(lookup(destination.value, "access_control_translation", {}))) == 0 ? [] : [lookup(destination.value, "access_control_translation", {})]

                content {
                  owner = access_control_translation.value.owner
                }
              }
               
              dynamic "replication_time" {
                for_each = length(keys(lookup(destination.value, "replication_time", {}))) == 0 ? [] : [lookup(destination.value, "replication_time", {})]

                content {
                  status  = replication_time.value.status
                  minutes = replication_time.value.minutes
                }
              }

              dynamic "metrics" {
                for_each = length(keys(lookup(destination.value, "metrics", {}))) == 0 ? [] : [lookup(destination.value, "metrics", {})]

                content {
                  status  = metrics.value.status
                  minutes = metrics.value.minutes
                }
              }
            }
          }
          dynamic "source_selection_criteria" {
            for_each = length(keys(lookup(rules.value, "source_selection_criteria", {}))) == 0 ? [] : [lookup(rules.value, "source_selection_criteria", {})]

            content {

              dynamic "sse_kms_encrypted_objects" {
                for_each = length(keys(lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {}))) == 0 ? [] : [lookup(source_selection_criteria.value, "sse_kms_encrypted_objects", {})]

                content {

                  enabled = sse_kms_encrypted_objects.value.enabled
                }
              }
            }
          }
          dynamic "filter" {
            for_each = length(keys(lookup(rules.value, "filter", {}))) == 0 ? [{}] : []

            content {}
          }

          # Send `filter` if it is present and has at least one field
          dynamic "filter" {
            for_each = length(keys(lookup(rules.value, "filter", {}))) != 0 ? [lookup(rules.value, "filter", {})] : []

            content {
              prefix = lookup(filter.value, "prefix", null)
              tags   = lookup(filter.value, "tags", null)
            }
          }
        }
      }
    }
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  count = var.encryption ? 1:0
  bucket = join("", aws_s3_bucket.main.*.id)

  rule {
    bucket_key_enabled = var.bucket_key_enabled
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = var.sse_algorithm
    }
  }
}

