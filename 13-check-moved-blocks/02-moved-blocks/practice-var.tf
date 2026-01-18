# PRACTICE CHALLENGE
# This is a Multi-Step Challenge. Follow carefully!

# STEP 1: DEFINE OLD RESOURCE
# Change real_world_example.tf:
# Rename "resource aws_s3_bucket new_shiny_name" -> "resource aws_s3_bucket legacy_name"
# Run `terraform apply`.
# Result: Created `aws_s3_bucket.legacy_name`.

# STEP 2: RENAME IN CODE
# Change "resource aws_s3_bucket legacy_name" -> "resource aws_s3_bucket new_shiny_name".
# Run `terraform plan`.
# Result: ☠️ DANGER! "Plan: 1 to add, 1 to destroy". (It wants to kill your bucket!)

# STEP 3: ADD MOVED BLOCK
# Add this to the file:
# moved {
#   from = aws_s3_bucket.legacy_name
#   to   = aws_s3_bucket.new_shiny_name
# }
# Run `terraform plan`.
# Result: ✅ "Plan: 0 to add, 0 to change, 0 to destroy".
# Terraform sees "Resource has moved". State is updated automatically.
