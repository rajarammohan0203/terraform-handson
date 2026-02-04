resource "local_file" "simulate_db" {
  filename = "${path.module}/db_config.txt"

  # In a real AWS Resource (like aws_db_instance), the 'password' field 
  # is Write-Only. You set it, but you can NEVER read it back.
  content = "password=${var.db_password}"
}

output "debug_password" {
  # This tries to read the password back.
  # For Write-Only arguments, this output would be empty or error out
  # because the provider doesn't give it back to Terraform!
  value     = local_file.simulate_db.content
  sensitive = true
}
