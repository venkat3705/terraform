resource "aws_s3_bucket" "main" {
    bucket = var.bucket_name
    acl = var.acl

    dynamic "versioning" {
      for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]

      content {
        enabled = lookup(versioning.value, "enabled", null)
        mfa_delete = lookup(versioning.value, "mfa_delete", null)
      }
    }

    dynamic "website" {
      for_each = length(keys(var.website)) == 0 ? [] : [var.website]

      content {
        index_document  = lookup (website.value, "index_document", null)
        error_document  = lookup (website.value, "error_document", null) 
        redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
        routing_rules            = lookup(website.value, "routing_rules", null)
      }
    }

    dynamic "lifecycle_rule" {
      for_each = try(jsondecode(var.lifecycle_rule), var.lifecycle_rule)

      content {
        id                                     = lookup(lifecycle_rule.value, "id", null)
        prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
        tags                                   = lookup(lifecycle_rule.value, "tags", null)
        abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)
        enabled                                = lifecycle_rule.value.enabled

        # Max 1 block - expiration
        dynamic "expiration" {
          for_each = length(keys(lookup(lifecycle_rule.value, "expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "expiration", {})]

          content {
            date                         = lookup(expiration.value, "date", null)
            days                         = lookup(expiration.value, "days", null)
            expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
          }
        }

      # Several blocks - transition
        dynamic "transition" {
          for_each = lookup(lifecycle_rule.value, "transition", [])

          content {
            date          = lookup(transition.value, "date", null)
            days          = lookup(transition.value, "days", null)
            storage_class = transition.value.storage_class
          }
        }

      # Max 1 block - noncurrent_version_expiration
        dynamic "noncurrent_version_expiration" {
          for_each = length(keys(lookup(lifecycle_rule.value, "noncurrent_version_expiration", {}))) == 0 ? [] : [lookup(lifecycle_rule.value, "noncurrent_version_expiration", {})]

          content {
            days = lookup(noncurrent_version_expiration.value, "days", null)
          }
        }

      # Several blocks - noncurrent_version_transition
        dynamic "noncurrent_version_transition" {
          for_each = lookup(lifecycle_rule.value, "noncurrent_version_transition", [])

          content {
            days          = lookup(noncurrent_version_transition.value, "days", null)
            storage_class = noncurrent_version_transition.value.storage_class
          }
        }
      }
    }
  
}