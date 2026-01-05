variable "db_password" {
  description = "the database password to store in SSM"
  type        = string
  sensitive   = true # Toggles the masking behavior
}
