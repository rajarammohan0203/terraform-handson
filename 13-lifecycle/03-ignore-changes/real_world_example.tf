# ---------------------------------------------------------------------------------------------------------------------
# LIFECYCLE: IGNORE CHANGES
# ---------------------------------------------------------------------------------------------------------------------
# PROBLEM:
# External systems (AutoScaling, AWS Config, Lambda, or Humans) change the resource.
# Terraform sees this as "Drift" and tries to revert it back to the code.
# We want Terraform to STOP reverting specific fields.

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "Ignore-Changes-Demo"
    Env  = "Dev"
  }

  lifecycle {
    # IGNORE changes to tags.
    # If I manually add a "CostCenter" tag in the Console, Terraform will NOT remove it.
    ignore_changes = [
      tags,
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# NOTE:
# Common use case is "user_data" (if it changes heavily) or "desired_capacity" in Auto Scaling Groups.
# ---------------------------------------------------------------------------------------------------------------------
