# ---------------------------------------------------------------------------------------------------------------------
# TERNARY OPERATOR (? :)
# ---------------------------------------------------------------------------------------------------------------------
# Syntax: condition ? true_value : false_value
# This is the basic conditional expression in Terraform

# EXAMPLE 1: Choose instance type based on environment
resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
  #               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #               If prod → t2.large, else → t2.micro

  tags = {
    Name        = "app-${var.environment}"
    Environment = var.environment
    Type        = var.environment == "prod" ? "Production" : "Development"
  }
}

# EXAMPLE 2: Enable/disable monitoring
resource "aws_instance" "monitored_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  monitoring    = var.enable_monitoring ? true : false
  #               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #               If enable_monitoring is true → true, else → false

  tags = {
    Name       = "monitored-server"
    Monitoring = var.enable_monitoring ? "ON" : "OFF"
  }
}

# OUTPUTS
output "app_server_type" {
  value = "Environment: ${var.environment}, Instance Type: ${aws_instance.app_server.instance_type}"
}

output "monitoring_status" {
  value = var.enable_monitoring ? "Monitoring is ENABLED" : "Monitoring is DISABLED"
}
