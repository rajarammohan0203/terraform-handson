# ---------------------------------------------------------------------------------------------------------------------
# MOVED BLOCKS: REFACTORING WITHOUT TEARS
# ---------------------------------------------------------------------------------------------------------------------
# Scenario:
# 1. You originally named your resource "aws_s3_bucket.legacy_name".
# 2. You deployed it. State has "aws_s3_bucket.legacy_name".
# 3. You decide to rename it to "aws_s3_bucket.new_shiny_name" to match naming standards.

# PROBLEM:
# Terraform thinks you DELETED "legacy_name" and ADDED "new_shiny_name".
# It wants to DESTROY your bucket (and data!) and create a new one.

# SOLUTION:
# moved { from = old, to = new }
# Tells Terraform: "I just renamed it in the code. Please rename it in the State file too."

resource "aws_s3_bucket" "new_shiny_name" {
  bucket = var.bucket_name
    
  tags = {
    Name = "My Bucket"
  }
}

# THE MAGIC BLOCK
# Uncomment this AFTER creating the resource with the old name (see Practice steps).
# moved {
#   from = aws_s3_bucket.legacy_name
#   to   = aws_s3_bucket.new_shiny_name
# }
