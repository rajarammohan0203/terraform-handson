# ---------------------------------------------------------------------------------------------------------------------
# LIFECYCLE: CREATE BEFORE DESTROY
# ---------------------------------------------------------------------------------------------------------------------
# PROBLEM:
# Default Terraform Behavior = Destroy Old Resource -> Create New Resource.
# For a Web Server, this means DOWNTIME.

# SOLUTION:
# lifecyle { create_before_destroy = true }
# Terraform creates the NEW server first (v2), verifies it, and ONLY THEN destroys the old one (v1).

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name    = "Zero-Downtime-Server"
    Version = "v1" # Change this to v2 to create a replacement event
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CRITICAL NOTE:
# This is mandatory for things like "Launch Configurations" in Auto Scaling Groups,
# because you cannot delete a Launch Config that is currently in use.
# You MUST create the new one first, attach it, and then delete the old one.
# ---------------------------------------------------------------------------------------------------------------------
