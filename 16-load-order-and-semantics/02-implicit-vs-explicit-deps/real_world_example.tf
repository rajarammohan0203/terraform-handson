# ---------------------------------------------------------------------------------------------------------------------
# DEPENDENCIES: IMPLICIT VS EXPLICIT
# ---------------------------------------------------------------------------------------------------------------------

# 1. IMPLICIT DEPENDENCY (Automatic)
# Terraform knows "aws_instance" needs "aws_security_group" because we reference it (sg.id).
# Current Order: SG -> Instance.

resource "aws_security_group" "sg" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # REFERENCE creates IMPLICIT dependency
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = { Name = "Web-Server" }
}

# ---------------------------------------------------------------------------------------------------------------------
# 2. EXPLICIT DEPENDENCY (Manual "depends_on")
# ---------------------------------------------------------------------------------------------------------------------
# Scenario: An S3 Bucket MUST exist before we can upload a file to it.
# (Implicit works here usually, but let's say the Instance needs to wait for the File upload).

resource "aws_s3_bucket" "config" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "config_file" {
  bucket  = aws_s3_bucket.config.id
  key     = "config.json"
  content = "{\"status\": \"active\"}"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # PROBLEM: The user_data script tries to download s3://.../config.json
  # If the instance starts BEFORE the file is uploaded, it fails.
  # Terraform DOES NOT know about the string inside user_data.

  user_data = <<-EOF
              #!/bin/bash
              aws s3 cp s3://${var.bucket_name}/config.json /tmp/config.json
              EOF

  tags = { Name = "App-Server" }

  # SOLUTION: Force Terraform to wait for the object.
  depends_on = [
    aws_s3_object.config_file
  ]
}
