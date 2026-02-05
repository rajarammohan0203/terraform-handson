resource "aws_s3_bucket" "data_lake" {
  bucket = "my-corporate-data-lake-local"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_config" {
  bucket = aws_s3_bucket.data_lake.id

  # DYNAMIC BLOCK: Lifecycle Rule
  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      # Nested Dynamic Block (Optional Filter)
      filter {
        prefix = rule.value.prefix
      }

      # Nested Dynamic Block: Transition
      # We check if 'transition_days' is set (not null)
      dynamic "transition" {
        for_each = rule.value.transition_days != null ? [1] : []
        content {
          days          = rule.value.transition_days
          storage_class = rule.value.storage_class
        }
      }

      # Nested Dynamic Block: Expiration
      dynamic "expiration" {
        for_each = rule.value.expiration_days != null ? [1] : []
        content {
          days = rule.value.expiration_days
        }
      }
    }
  }
}
