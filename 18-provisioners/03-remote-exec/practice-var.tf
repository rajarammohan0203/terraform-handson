# PRACTICE CHALLENGE
# 1. Understanding Taints.
#    In a real environment, changing the inline command to "sudo apt-get install -y invalid-package" will fail.
#    Terraform will say: "Error: remote-exec failed."
#    Then validation: `terraform state list` -> `aws_instance.web_server (tainted)`.
#
# 2. Next `terraform apply`:
#    Terraform says: "Instance is tainted, so must be replaced."
#    It destroys the half-broken server and builds a new one.
