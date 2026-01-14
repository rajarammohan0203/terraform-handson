# ---------------------------------------------------------------------------------------------------------------------
# DATA SOURCES: BASICS (Context & Identity)
# ---------------------------------------------------------------------------------------------------------------------
# Data Sources allow you to READ information from the cloud environment.
# Unlike "Resources" (which create things), Data Sources only FETCH things.

# 1. Who am I? (AWS Caller Identity)
# Fetches the Account ID, User ARN, and User ID of the credentials running Terraform.
data "aws_caller_identity" "current" {}

# 2. Where am I? (Current Region)
# Fetches details about the region defined in provider.tf (us-east-1).
data "aws_region" "current" {}

# 3. What is available here? (Availability Zones)
# Fetches a list of AZs in the current region (e.g., us-east-1a, us-east-1b).
data "aws_availability_zones" "available" {
  state = "available"
}

# ---------------------------------------------------------------------------------------------------------------------
# REAL WORLD USAGE
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: Create an S3 bucket that includes the Account ID in the name to ensure global uniqueness.
# S3 buckets must be globally unique. Adding Account ID is a best practice.

resource "aws_s3_bucket" "audit_logs" {
  # Usage: data.<TYPE>.<NAME>.<ATTRIBUTE>
  bucket = "audit-logs-${data.aws_caller_identity.current.account_id}-${var.environment}"

  tags = {
    Region    = data.aws_region.current.name
    CreatedBy = data.aws_caller_identity.current.arn
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS (What did we find?)
# ---------------------------------------------------------------------------------------------------------------------

output "account_details" {
  value = {
    account_id = data.aws_caller_identity.current.account_id
    user_arn   = data.aws_caller_identity.current.arn
  }
}

output "region_details" {
  value = {
    region_name = data.aws_region.current.name
    description = data.aws_region.current.description
  }
}

output "available_zones" {
  value = data.aws_availability_zones.available.names
}
