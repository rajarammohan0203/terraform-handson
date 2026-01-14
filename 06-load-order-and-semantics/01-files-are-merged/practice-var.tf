# PRACTICE CHALLENGE
# ---------------------------------------------------------------------------------------------------------------------
# 1. Create a new file called `z_outputs.tf`
# ---------------------------------------------------------------------------------------------------------------------
# Terraform loads files in alphabetical order? NO! It loads ALL of them.
# The name "z_outputs.tf" starts with Z, but it still works perfectly to output values 
# from resources defined in "network.tf" (starts with N).

# UNCOMMENT the code below and place it in a NEW file (or just run it here to test):

# output "server_ip" {
#   value = aws_instance.app_server.private_ip
# }

# output "vpc_id" {
#   value = aws_vpc.main.id
# }
