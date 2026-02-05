# ---------------------------------------------------------------------------------------------------------------------
# FILE: server.tf
# ---------------------------------------------------------------------------------------------------------------------
# This resource references "aws_subnet.main.id" which is defined in "network.tf".
# Terraform merges all *.tf files in memory before execution.

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # CROSS-FILE REFERENCE
  subnet_id = aws_subnet.main.id

  tags = {
    Name = "${var.app_name}-server"
    File = "server.tf"
  }
}
