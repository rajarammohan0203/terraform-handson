# ---------------------------------------------------------------------------------------------------------------------
# PROVISIONER: REMOTE-EXEC
# ---------------------------------------------------------------------------------------------------------------------
# Concept: SSH into the server and run shell commands.
# Use Case: Installing software, moving files, starting services.

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/my-key.pem")
    host        = self.public_ip
  }

  # ---------------------------------------------------------------------------------------------------------------------
  # THE TAINTING CONCEPT
  # ---------------------------------------------------------------------------------------------------------------------
  # If "remote-exec" fails (e.g., `apt-get` fails), Terraform marks this instance as TAINTED.
  # TAINTED means: "This resource is half-setup. It is dangerous. I will destroy it next time."
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ${var.package_name}",
      "sudo systemctl start ${var.package_name}"
    ]
  }
}
