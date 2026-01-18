# ---------------------------------------------------------------------------------------------------------------------
# INPUT VARIABLE VALIDATION
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO:
# We want to prevent users from deploying with typos or invalid configurations.
# This validation happens BEFORE Terraform even calls the AWS API.
# It is the "First Line of Defense".

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  
  tags = {
    Name = "Web-${var.environment}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# WHY IS THIS USEFUL?
# If a user types "development" instead of "dev", `terraform plan` fails instantly.
# This saves time and prevents misnamed resources in your cloud.
# ---------------------------------------------------------------------------------------------------------------------
