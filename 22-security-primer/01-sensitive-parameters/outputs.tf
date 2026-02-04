output "connection_string" {
  # Terraform will REFUSE to output this unless you mark the output as sensitive too!
  value     = "postgresql://admin:${var.db_password}@localhost:5432"
  sensitive = true
}

output "safe_value" {
  value = "This is safe to show"
}
