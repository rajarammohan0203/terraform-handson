# ---------------------------------------------------------------------------------------------------------------------
# PROVISIONER: FILE (Copying Files)
# ---------------------------------------------------------------------------------------------------------------------
# Concept: Copy a file from YOUR machine -> THE NEW SERVER.
# Limitation: Requires Network Connectivity (SSH/WinRM) to the server.
#             In LocalStack/Mock endpoints, this often fails or hangs because
#             "mock" check instances usually don't accept real SSH connections.

resource "aws_instance" "app" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = var.key_name

  # CONNECTION BLOCK
  # Tells Terraform how to connect to the instance.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/my-key.pem")
    host        = self.public_ip
  }

  # THE PROVISIONER
  provisioner "file" {
    source      = "app-config.conf"      # File on your machine
    destination = "/home/ubuntu/app.conf" # Path on the server
  }
  
  # Note: For this to work, you need:
  # 1. A real Security Group allowing Port 22.
  # 2. A real Key Pair.
  # 3. A real Public IP reachable from your laptop.
}
