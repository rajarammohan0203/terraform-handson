# ---------------------------------------------------------------------------------------------------------------------
# LIFECYCLE: PREVENT DESTROY
# ---------------------------------------------------------------------------------------------------------------------
# PROBLEM:
# Accidental deletion of critical resources (Databases, S3 buckets with data).
# Even "terraform destroy" should be blocked.

# SOLUTION:
# lifecycle { prevent_destroy = true }
# Terraform will ERROR and EXIT if any plan tries to destroy this resource.

resource "aws_s3_bucket" "critical_db" {
  bucket = "prod-db-backup-998877"

  lifecycle {
    prevent_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# HOW TO DELETE IT (If you really need to):
# You must edit this file, remove the lifecycle block, apply, and THEN destroy.
# It is a safety latch.
# ---------------------------------------------------------------------------------------------------------------------
