# ---------------------------------------------------------------------------------------------------------------------
# PRACTICE EXERCISES
# ---------------------------------------------------------------------------------------------------------------------

# 1. string
# Create a variable named "bucket_name" of type string.
# Give it a default value (e.g., "my-terraform-test-bucket").

variable "bucket_name" {
   type        = string
   default     = "my-terraform-test-bucket"
 }

# 2. number
# Create a variable named "database_port" of type number.
# Assign a default value of 5432.

variable "database_port" {
   type        = number
   default     = 5432
}

# 3. bool
# Create a variable named "enable_versioning" of type bool.
# Default it to true.

variable "enable_versioning" {
   type        = bool
   default     = true
}

# 4. Outputs
# Create an output that prints the connection string using your variables.
# e.g., "Connecting to database on port 5432"

output "db_connection" {
  value = "Connecting to database on port ${var.database_port}"
}

