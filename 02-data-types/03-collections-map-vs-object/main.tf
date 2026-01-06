# ---------------------------------------------------------------------------------------------------------------------
# OBJECT EXAMPLE: STRUCTURAL CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------
# We use an OBJECT when we need to group related settings of DIFFERENT types.
resource "aws_instance" "app_server" {
  # Accessing object attributes using dot notation
  ami           = var.instance_config.ami
  instance_type = var.instance_config.instance_type
  monitoring    = var.instance_config.monitoring

  root_block_device {
    volume_size = var.instance_config.volume_size
  }

  # ---------------------------------------------------------------------------------------------------------------------
  # MAP EXAMPLE: TAGS
  # ---------------------------------------------------------------------------------------------------------------------
  # We use a MAP when we have a collection of similar items (usually strings).
  tags = var.project_tags
}

output "instance_summary" {
  value = "Created ${var.instance_config.instance_type} instance with tags: ${join(", ", keys(var.project_tags))}"
}
