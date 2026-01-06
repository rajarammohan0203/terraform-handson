# ---------------------------------------------------------------------------------------------------------------------
# TUPLE EXAMPLE: DATABASE CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------
# Tuples are useful when you want to pass a rigid sequence of arguments.
# However, they can be hard to read because you have to remember "Index 0 is Class, Index 1 is Port".
# Objects are usually preferred for clarity, but Tuples are good for concise, ordered data.

output "db_summary" {
  value = "Deploying ${var.db_settings[0]} on port ${var.db_settings[1]} (Multi-AZ: ${var.db_settings[2]})"
}

# Simulating a resource usage
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Database Security Group"

  ingress {
    from_port   = var.db_settings[1] # Accessing Index 1 (Port)
    to_port     = var.db_settings[1]
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Type = "Database-${var.db_settings[0]}" # Accessing Index 0 (Class)
  }
}
