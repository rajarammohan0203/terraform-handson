# PRACTICE CHALLENGE
# 1. Run `terraform apply`.
# 2. Check the folder: You should see "inventory.txt" created.
#    `cat inventory.txt`
# 3. Destroy the infrastructure: `terraform destroy`.
# 4. Check the folder: You should see "destroy_log.txt" created.

# CHALLENGE:
# Change the command to something that fails (e.g., `command = "exitt 1"` typo).
# Remove `on_failure = continue`.
# Apply again.
# OBSERVE: Terraform says "Error applying plan".
# The resource is marked as "Tainted".
# The NEXT apply will destroy and recreate it.
