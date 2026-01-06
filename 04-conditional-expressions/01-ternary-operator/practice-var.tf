# PRACTICE: Create an S3 bucket with conditional encryption
# Uncomment to test:

# variable "enable_encryption" {
#   type    = bool
#   default = true
# }

# resource "aws_s3_bucket" "practice_bucket" {
#   bucket = "practice-ternary-bucket"
# }

# output "encryption_status" {
#   value = var.enable_encryption ? "Encryption ENABLED" : "Encryption DISABLED"
# }
