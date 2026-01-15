# PRACTICE CHALLENGE
# Uncomment to test.

# ---------------------------------------------------------------------------------------------------------------------
# 1. Challenge: Lookup with Fallback
# ---------------------------------------------------------------------------------------------------------------------
# variable "ami_map" {
#   default = {
#     us-east-1 = "ami-111"
#     us-west-2 = "ami-222"
#   }
# }
#
# output "ami_for_europe" {
#   # Try to find "eu-central-1". If missing, default to "ami-999"
#   value = lookup(var.ami_map, "eu-central-1", "ami-999")
# }

# ---------------------------------------------------------------------------------------------------------------------
# 2. Challenge: Zipmap Two Lists
# ---------------------------------------------------------------------------------------------------------------------
# output "fruit_colors" {
#   value = zipmap(["apple", "banana"], ["red", "yellow"])
#   # Expected: { "apple" = "red", "banana" = "yellow" }
# }
