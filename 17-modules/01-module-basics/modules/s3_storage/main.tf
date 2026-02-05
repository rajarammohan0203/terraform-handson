# This is the "TEMPLATE" (The Child Module)
# We define how an S3 bucket should look once.

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    ManagedBy   = "Terraform Module"
  }
}
