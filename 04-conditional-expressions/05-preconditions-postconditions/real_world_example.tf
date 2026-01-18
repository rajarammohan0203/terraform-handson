# ---------------------------------------------------------------------------------------------------------------------
# LIFECYCLE: PRECONDITIONS & POSTCONDITIONS
# ---------------------------------------------------------------------------------------------------------------------
# New in Terraform 1.2+
# They allow you to validate DATA (resources, data sources) not just Variables.

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  # PRECONDITION: Check inputs/data BEFORE creating the resource.
  lifecycle {
    precondition {
      # We only allow "t2" family instances for this legacy app.
      condition     = substr(var.instance_type, 0, 3) == "t2."
      error_message = "This Application only supports T2 instance types."
    }
  }
  
  tags = {
    Name = "Precondition-Demo"
  }
}

resource "aws_ebs_volume" "storage" {
  availability_zone = "us-east-1a"
  size              = var.volume_size

  # POSTCONDITION: Check the resource AFTER it is created.
  lifecycle {
    postcondition {
      # Ensure we didn't accidentally create a tiny volume.
      condition     = self.size >= 10
      error_message = "Volume size must be at least 10 GB for performance reasons."
    }
  }
}
