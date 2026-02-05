# ---------------------------------------------------------------------------------------------------------------------
# ROOT MODULE
# ---------------------------------------------------------------------------------------------------------------------
# This replicates a "Developer Experience".
# The Dev just wants a DB. They don't want to worry about Security Groups or binding them together.

# Dummy VPC for the example
# Dummy VPC (Keeping just for context, though not strictly needed for DynamoDB)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "marketing_db" {
  source = "./modules/database"

  # Inputs
  table_name = "marketing-users-db"
}

output "db_arn" {
  value = module.marketing_db.table_arn
}
