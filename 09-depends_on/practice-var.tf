# PRACTICE CHALLENGE
# Uncomment to test.

# ---------------------------------------------------------------------------------------------------------------------
# Challenge: Order of Operations
# ---------------------------------------------------------------------------------------------------------------------
# We have 3 dummy resources using "null_resource".
# Make "Step 3" wait for "Step 2", and "Step 2" wait for "Step 1".

# resource "null_resource" "step_1" {
#   provisioner "local-exec" {
#     command = "echo 'Step 1 Complete'"
#   }
# }

# resource "null_resource" "step_2" {
#   provisioner "local-exec" {
#     command = "echo 'Step 2 Complete'"
#   }
#   # depends_on = [null_resource.step_1]
# }

# resource "null_resource" "step_3" {
#   provisioner "local-exec" {
#     command = "echo 'Step 3 Complete'"
#   }
#   # depends_on = [null_resource.step_2]
# }
