# 1. We define the resource block FIRST.
# Even though this resource exists in AWS, Terraform doesn't know about it yet.
resource "aws_s3_bucket" "imported_bucket" {
  bucket = "my-manual-bucket"

  tags = {
    CreatedBy = "ManualCLI"
  }
}
