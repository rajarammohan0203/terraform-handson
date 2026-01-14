# ---------------------------------------------------------------------------------------------------------------------
# LOCALS: SIMPLIFICATION
# ---------------------------------------------------------------------------------------------------------------------
# Locals can drastically simplify complex resources by moving logic OUT of the resource block.
# This makes the resource block easy to read ("What am I building?") vs ("How do I calculate it?").

locals {
  # --------------------------------------------------------
  # SIMPLIFICATION 1: Complex User Data Script
  # --------------------------------------------------------
  # Instead of putting a 20-line HEREDOC script inside the instance resource,
  # we define it here. It keeps the instance block clean.

  user_data_script = <<-EOF
    #!/bin/bash
    echo "Starting App: ${var.app_name}"
    echo "Environment: ${var.env}"
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
  EOF

  # --------------------------------------------------------
  # SIMPLIFICATION 2: Consolidating Naming Logic
  # --------------------------------------------------------
  # Instead of repeating "${var.app_name}-${var.env}-${var.extra_settings["tier"]}" everywhere,
  # we calculate it once.

  full_resource_name = "${var.app_name}-${var.env}-${var.extra_settings["tier"]}"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # CLEAN! No complex logic here.
  user_data = local.user_data_script

  tags = {
    # CLEAN! Just referencing the name.
    Name = local.full_resource_name
  }
}

output "simplified_view" {
  value = {
    name_used   = local.full_resource_name
    script_used = "View local.user_data_script in code"
  }
}
