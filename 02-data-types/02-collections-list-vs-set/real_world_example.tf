# ---------------------------------------------------------------------------------------------------------------------
# 1. LIST EXAMPLE: Security Group Rules
# ---------------------------------------------------------------------------------------------------------------------
# Purpose: Pass a LIST of data directly to a resource argument.
# In this example, 'cidr_blocks' EXPECTS a list of strings.
# This demonstrates the most common use of lists: passing multiple values to a single configuration parameter.

resource "aws_security_group" "firewall" {
  name        = "example-firewall"
  description = "Allow inbound traffic from specific IPs"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # DIRECT USAGE OF LIST
    # We pass the list variable directly. No loops needed!
    cidr_blocks = var.allowed_ips
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. SET EXAMPLE: IAM Users
# ---------------------------------------------------------------------------------------------------------------------
# Purpose: Create MULTIPLE resources from a unique collection.
# Because there is no "aws_iam_users" (plural) resource that takes a list of names,
# we must use a LOOP (for_each) to create one resource per name.
#
# We use a SET because we want to ensure uniqueness. If 'alice' is in the list twice,
# we don't want to try and create the user 'alice' twice (which would fail).

resource "aws_iam_user" "users" {
  # for_each works best with sets. It creates one resource instance for each item.
  for_each = var.iam_usernames
  name     = each.value
}

# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXAMPLES (Using variables from practice.tf)
# ---------------------------------------------------------------------------------------------------------------------

# PRACTICE: S3 Buckets using SET (from practice.tf)
resource "aws_s3_bucket" "practice_buckets" {
  for_each = var.bucket_names
  bucket   = each.value
}

# PRACTICE: Output using LIST (from practice.tf)
output "practice_zones" {
  value = "Practice zones defined: ${join(", ", var.zones)}"
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "firewall_rules" {
  value = "Firewall allows: ${join(", ", var.allowed_ips)}"
}

output "created_users" {
  value = [for user in aws_iam_user.users : user.name]
}

output "practice_buckets_created" {
  value = [for bucket in aws_s3_bucket.practice_buckets : bucket.id]
}
