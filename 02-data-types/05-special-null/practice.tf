# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES
# ---------------------------------------------------------------------------------------------------------------------

# 1. NULL EXERCISE: EC2 Key Pair
# Create a variable "key_name" of type string with default = null.
# Used for optional SSH access.

# variable "key_name" {
#   type    = ...
#   default = ...
# }

# 2. OUTPUT EXERCISE
# Create an output that prints "Key is set" if key_name is not null,
# or "No key provided" if it is null.

# output "key_status" {
#   value = var.key_name != null ? ... : ...
# }
