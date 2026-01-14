# PRACTICE EXERCISES
# Uncomment the content below to practice!

# ---------------------------------------------------------------------------------------------------------------------
# 1. Define a Local for Company Name
# ---------------------------------------------------------------------------------------------------------------------
# Goal: Create a local variable `company` with value "AcmeCorp"
# and use it to create an output.

# locals {
#   company = "AcmeCorp"
# }

# output "practice_company_name" {
#   value = "Properties of ${local.company}"
# }

# ---------------------------------------------------------------------------------------------------------------------
# 2. Reuse a Local in a Map
# ---------------------------------------------------------------------------------------------------------------------
# Goal: Use `local.company` inside a map definition.

# locals {
#   resource_metadata = {
#     Company = local.company
#     Department = "IT"
#   }
# }

# output "practice_metadata" {
#   value = local.resource_metadata
# }
