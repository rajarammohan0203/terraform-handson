# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM DEPENDENCIES
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# 1. IMPLICIT DEPENDENCY (Automatic)
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: An EC2 Instance CANNOT exist without a Security Group.
# Terraform sees `aws_security_group.sg.id` inside `aws_instance` and knows:
# "I MUST create the SG first."

resource "aws_security_group" "sg" {
  name        = "allow-http"
  description = "Allow HTTP traffic"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # Terraform sees this reference -> IMPLICIT DEPENDENCY created.
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.instance_name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. EXPLICIT DEPENDENCY (Manual "depends_on")
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: The Application inside the instance tries to read a config file from S3 on startup.
# Terraform creates Instances and S3 Objects in PARALLEL by default.
# If the Instance starts BEFORE the file is uploaded -> App Crashes.
# We must FORCE Terraform to wait.

resource "aws_s3_bucket" "config" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "config_file" {
  bucket  = aws_s3_bucket.config.id
  key     = "app-config.json"
  content = "{ \"db_host\": \"localhost\" }"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "App-Server-With-Config"
  }

  # Startup script that downloads the file
  user_data = <<-EOF
              #!/bin/bash
              aws s3 cp s3://${var.bucket_name}/app-config.json /etc/config.json
              EOF

  # ⚠️ CRITICAL: Without this, the instance might start before the file exists!
  depends_on = [
    aws_s3_object.config_file
  ]
}
