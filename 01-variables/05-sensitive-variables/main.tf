# We use SSM Parameter Store instead of AWS RDS
# Reason: RDS is often a Pro feature in LocalStack, SSM is free and perfect for secrets.

resource "aws_ssm_parameter" "db_password" {
  name        = "/production/database/password"
  description = "The database password"
  type        = "SecureString"
  value       = var.db_password
}

# Outputting the Name of the parameter (safe)
output "parameter_name" {
  value = aws_ssm_parameter.db_password.name
}

# Attempting to output the value (will be masked)
output "password_value" {
  value     = aws_ssm_parameter.db_password.value
  sensitive = true
}
