# ---------------------------------------------------------------------------------------------------------------------
# CONDITIONAL RESOURCE CREATION
# ---------------------------------------------------------------------------------------------------------------------
# Use count with ternary operator to create or skip resources

# EXAMPLE 1: Create backup bucket ONLY in production
resource "aws_s3_bucket" "backup" {
  count = var.environment == "prod" ? 1 : 0
  #        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #        If prod → count = 1 (create), else → count = 0 (don't create)
  bucket = "prod-backup-bucket"
}

# EXAMPLE 2: Create monitoring dashboard ONLY if create_backup is true
resource "aws_s3_bucket" "monitoring" {
  count = var.create_backup ? 1 : 0
  #        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #        If true → create, else → skip
  bucket = "monitoring-bucket"
}

# EXAMPLE 3: Create multiple resources conditionally
resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "app-server"
  }
}

# Create a load balancer ONLY in production
resource "aws_instance" "load_balancer" {
  count = var.environment == "prod" ? 1 : 0

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.small"

  tags = {
    Name = "load-balancer"
  }
}

# OUTPUTS
output "backup_bucket_status" {
  value = var.environment == "prod" ? "Backup bucket created" : "No backup bucket (not prod)"
}

output "monitoring_bucket_status" {
  value = var.create_backup ? "Monitoring bucket created" : "No monitoring bucket"
}

output "load_balancer_created" {
  value = var.environment == "prod" ? "Load balancer created" : "No load balancer (not prod)"
}
