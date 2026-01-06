# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISE
# ---------------------------------------------------------------------------------------------------------------------
# Goal: Create multiple S3 buckets using count
# Uncomment the code below to test it!

# STEP 1: Define how many buckets to create
variable "bucket_count" {
  type    = number
  default = 3
}

# STEP 2: Define custom bucket names
variable "bucket_names" {
  type    = list(string)
  default = ["logs-bucket", "data-bucket", "backup-bucket"]
}

# STEP 3: Create the buckets using count
resource "aws_s3_bucket" "practice_buckets" {
  count  = var.bucket_count
  bucket = var.bucket_names[count.index]
}

# STEP 4: Output the bucket names
output "practice_bucket_names" {
  value = aws_s3_bucket.practice_buckets[*].bucket
}
