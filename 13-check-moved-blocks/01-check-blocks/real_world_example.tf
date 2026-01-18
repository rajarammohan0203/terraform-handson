# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM CHECK BLOCKS (TF 1.5+)
# ---------------------------------------------------------------------------------------------------------------------
# Unlike "preconditions" (which stop Apply), "check" blocks run CONTINUOUSLY.
# They are "Non-Blocking" warnings.
# Ideal for: "Is the website actually answering?" "Is the SSL cert expiring soon?"

resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name
}

# ---------------------------------------------------------------------------------------------------------------------
# THE CHECK BLOCK
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: We verify that the Bucket actually exists and is theoretically reachable.
# In a real AWS env, we would curl the Website Endpoint.
# In LocalStack, we mock this by checking if the bucket data source can read it.

check "bucket_health_check" {
  # This data source tries to read the bucket we just created.
  data "aws_s3_bucket" "check_bucket" {
    bucket = aws_s3_bucket.site.bucket
  }

  # ASSERTION
  assert {
    # Verify the bucket is in the correct region
    condition     = data.aws_s3_bucket.check_bucket.region == "us-east-1"
    error_message = "Bucket is not in the expected region! Latency alert!"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: BUDGET ALERT (Soft Limit)
# ---------------------------------------------------------------------------------------------------------------------
# User Question: "Can checks prevent creation?"
# Answer: NO. Checks are NON-BLOCKING. They only Warn.
# If you want to BLOCK creation (Hard Limit), use a "lifecycle { precondition }" instead.

check "budget_alert" {
  assert {
    condition     = var.current_spend < var.budget_limit
    error_message = "⚠️  BUDGET EXCEEDED! Current spend ($${var.current_spend}) is higher than limit ($${var.budget_limit})."
  }
}
