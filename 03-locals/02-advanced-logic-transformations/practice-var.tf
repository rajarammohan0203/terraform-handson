# PRACTICE EXERCISES
# Uncomment to test!

# ---------------------------------------------------------------------------------------------------------------------
# 1. Calculate Storage Size based on Environment
# ---------------------------------------------------------------------------------------------------------------------
# Goal: Create a local `storage_size` that is 100 if env is "prod", else 20.

# locals {
#   # Use the ternary operator: condition ? true_val : false_val
#   storage_size = local.env_clean == "prod" ? 100 : 20
# }

# output "practice_storage" {
#   value = "For ${local.env_clean}, we need ${local.storage_size} GB"
# }

# ---------------------------------------------------------------------------------------------------------------------
# 2. Advanced: Combine Map with Local
# ---------------------------------------------------------------------------------------------------------------------
# Goal: Create a map where keys are dynamically generated from locals.

# locals {
#   dynamic_map = {
#     "${local.env_clean}_api" = "Active"
#     "${local.env_clean}_db"  = "Standby"
#   }
# }

# output "practice_map" {
#   value = local.dynamic_map
# }
