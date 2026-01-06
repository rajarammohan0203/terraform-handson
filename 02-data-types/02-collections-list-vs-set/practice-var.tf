# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES
# ---------------------------------------------------------------------------------------------------------------------

# 1. LIST EXERCISE: Availability Zones
# Create a variable "zones" of type list(string).
# Example: ["us-east-1a", "us-east-1b"]


variable "zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# 2. SET EXERCISE: S3 Bucket Names
# Create a variable "bucket_names" of type set(string).
# Example: ["log-bucket", "data-bucket"]
# Remember, bucket names must be unique!

variable "bucket_names" {
  type    = set(string)
  default = ["log-bucket", "data-bucket"]
}

# 3. TRY IT:
# Add a resource to 'real_world_example.tf' using these variables!
# Hint: Use 'for_each' for the buckets (Set) to create multiple buckets.
# Hint: Use the 'zones' list to configure a Subnet (requires a VPC).
