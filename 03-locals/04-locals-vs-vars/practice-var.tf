# PRACTICE QUIZ
# Uncomment the correct answer to fix the code.

# SCENARIO: You want to combine "Team" and "CostCenter" variables into a single tag string.
# Where should you do this?

variable "team" { default = "DevOps" }
variable "cost" { default = "1001" }

# OPTION A: Inside a Variable? (Will this work?)
# variable "full_tag" {
#   default = "${var.team}-${var.cost}" # ERROR! Variables cannot interpolate other variables.
# }

# OPTION B: Inside a Local?
# locals {
#   full_tag = "${var.team}-${var.cost}"
# }

# output "quiz_result" {
#   value = local.full_tag
# }
