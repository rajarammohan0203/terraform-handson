# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES
# ---------------------------------------------------------------------------------------------------------------------

# 1. MAP EXERCISE: S3 Bucket Tags
# Create a variable "bucket_tags" of type map(string).
# Add keys like "Team", "CostCenter".

# variable "bucket_tags" {
#   type    = ...
#   default = ...
# }

# 2. OBJECT EXERCISE: S3 Lifecycle Rule
# Create a variable "lifecycle_rule" of type object.
# Attributes:
#   - id      (string)
#   - enabled (bool)
#   - days    (number)

# variable "lifecycle_rule" {
#   type    = ...
#   default = ...
# }

# 3. Create Resources
# Try to create a simulated resource (or use outputs) to access these values!
# e.g. value = var.lifecycle_rule.days
