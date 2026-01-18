# ---------------------------------------------------------------------------------------------------------------------
# FOR_EACH: ITERATING OVER SETS (Unique Lists)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO:
# We have a List of strings: ["assets", "logs", "backups"].
# We want to create one S3 Bucket for each.

# TRICK:
# "for_each" DOES NOT accept Lists. It only accepts Maps or Sets.
# We must use `toset(var.list)` to convert it.

resource "aws_s3_bucket" "buckets" {
  # Convert List -> Set
  for_each = toset(var.bucket_names)

  # For Sets: each.key and each.value are the SAME thing ("assets")
  bucket = "my-company-${each.key}-bucket-12345"

  tags = {
    Purpose = each.key
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: IAM USERS (From a List)
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_user" "set_users" {
  for_each = toset(var.user_names)
  name     = each.key
}

# ---------------------------------------------------------------------------------------------------------------------
# WHY NOT USE COUNT?
# If you used count = length(var.list):
# [0]="assets", [1]="logs", [2]="backups"
# If you delete "assets", then [0] becomes "logs".
# Terraform would DESTROY the "logs" bucket to recreate it at index [0]. Disaster!
# With toset(), keys are stable strings. Deleting "assets" only affects "assets".
# ---------------------------------------------------------------------------------------------------------------------
