# ---------------------------------------------------------------------------------------------------------------------
# PROVISIONER: LOCAL-EXEC
# ---------------------------------------------------------------------------------------------------------------------
# Concept: Run a script on YOUR machine (the machine running Terraform).
# Use Case: Saving IPs to an Ansible inventory file, triggering a Slack notification, etc.

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = var.instance_name
  }

  # ---------------------------------------------------------------------------------------------------------------------
  # 1. CREATION-TIME PROVISIONER
  # ---------------------------------------------------------------------------------------------------------------------
  # Runs ONLY during "terraform apply" when the resource is created.
  # If it fails, the resource is marked "Tainted".
  
  provisioner "local-exec" {
    command = "echo '${self.public_ip} - Created at ${timestamp()}' >> inventory.txt"
    
    # Valid options: "continue", "fail" (default)
    on_failure = continue 
  }

  # ---------------------------------------------------------------------------------------------------------------------
  # 2. DESTROY-TIME PROVISIONER
  # ---------------------------------------------------------------------------------------------------------------------
  # Runs ONLY during "terraform destroy".
  # Useful for cleanup (deleting the inventory line).
  
  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying instance...' >> destroy_log.txt"
    
    # Note: You cannot use ${self.public_ip} in destroy provisioners easily in older TF versions,
    # but generic cleanup scripts work fine.
  }
}
