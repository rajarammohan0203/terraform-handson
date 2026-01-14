# PRACTICE QUIZ
# Uncomment the correct answer to fix the code.

# ---------------------------------------------------------------------------------------------------------------------
# 1. Output the list of Service Names used by our region (Advanced)
# ---------------------------------------------------------------------------------------------------------------------
# Terraform exposes `data.aws_partition`.
# Try to declare it and output the "partition" (usually "aws" or "aws-cn").

# data "aws_partition" "current" {}

# output "cloud_partition" {
#   value = data.aws_partition.current.partition # Expected: "aws"
# }
