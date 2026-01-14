# ---------------------------------------------------------------------------------------------------------------------
# LOCALS VS VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

# 1. VARIABLES (INPUTS)
# - Defined in variables.tf
# - Can be overridden by the user (-var="env=prod")
# - CANNOT depend on other variables or resources.

# 2. LOCALS (INTERMEDIATE / CALCULATED)
# - Defined here.
# - CANNOT be overridden by the user directly.
# - CAN depend on variables, resources, and other locals.

locals {
  # We use locals to COMBINE or TRANSFORM variables.
  # You CANNOT do this in variables.tf (e.g., default = "${var.project}-${var.env}" is invalid!)
  bucket_name = "${lower(var.project)}-${lower(var.env)}-data-center"

  # We can also add static logic here
  is_production = var.env == "prod"
}

# ---------------------------------------------------------------------------------------------------------------------
# USING THEM
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "compare_bucket" {
  # We use the LOCAL for the calculated name
  bucket = local.bucket_name

  tags = {
    # We use the VARIABLE for raw input tracking
    OriginalProjectInput = var.project

    # We use LOCAL for logic
    IsProduction = local.is_production
  }
}

output "comparison" {
  value = {
    user_input_var   = var.project       # "CloudApp"
    calculated_local = local.bucket_name # "cloudapp-dev-data-center"
  }
}
