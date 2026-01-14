# ---------------------------------------------------------------------------------------------------------------------
# LOCALS: ADVANCED LOGIC & TRANSFORMATIONS
# ---------------------------------------------------------------------------------------------------------------------
# Locals are the "Calculation Layer".
# Instead of putting complex logic directly into a resource, do it in a local first.

locals {
  # 1. Input Cleaning
  # User might input "PrOd", "pRoD". We standardize it here.
  # Now "local.env_clean" is always "prod".
  env_clean = lower(var.env_name)

  # 2. Logic / Conditionals
  # If env is prod AND HA is true, we want 3 instances. Otherwise 1.
  instance_count = local.env_clean == "prod" && var.high_availability ? 3 : 1

  # 3. Constructing Complex Strings (Cost Codes)
  # Format: dep-env-timestamp
  # We reuse the "cleaned" env variable here, not the messy raw input.
  cost_code = "${var.department_code}-${local.env_clean}-001"
}

# ---------------------------------------------------------------------------------------------------------------------
# RESOURCES USING CALCULATED VALUES
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "app_cluster" {
  # We use the CALCULATED count, not a raw variable
  count = local.instance_count

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name        = "app-${local.env_clean}-${count.index}" # app-prod-0
    CostCenter  = local.cost_code                         # finance-prod-001
    OriginalEnv = var.env_name                            # "PrOd" (Just to show the diff)
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# OUTPUTS
# ---------------------------------------------------------------------------------------------------------------------

output "logic_check" {
  value = {
    raw_input       = var.env_name
    cleaned_input   = local.env_clean
    instances_built = local.instance_count
    final_cost_code = local.cost_code
  }
  description = "Visualizing the transformation from Input -> Local -> Result"
}
