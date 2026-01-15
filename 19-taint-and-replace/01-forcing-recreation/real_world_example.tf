# ---------------------------------------------------------------------------------------------------------------------
# FORCING RECREATION (TAINT vs REPLACE)
# ---------------------------------------------------------------------------------------------------------------------
# Sometimes a resource is "corrupted" manually (e.g., someone deleted a file on the server).
# Terraform thinks it's fine (state matches config), but in reality, it's broken.
# We need to force Terraform to destroy and recreate it.

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name   = var.instance_name
    Status = "I might be broken"
  }
}

output "instance_id" {
  value = aws_instance.web.id
}
