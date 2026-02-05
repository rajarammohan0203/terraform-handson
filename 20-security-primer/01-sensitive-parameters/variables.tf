variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true # This is the magic flag!
  default     = "super-secret-password"
}
