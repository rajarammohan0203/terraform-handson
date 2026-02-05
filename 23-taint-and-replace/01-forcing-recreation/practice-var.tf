# PRACTICE CHALLENGE
# Run these commands in your terminal to master Taint/Replace.

# ---------------------------------------------------------------------------------------------------------------------
# 1. The Modern Way (-replace)
# ---------------------------------------------------------------------------------------------------------------------
# Command: terraform apply -replace="aws_instance.web"
# Goal: Recreate the instance in one go (Destroy + Create)

# ---------------------------------------------------------------------------------------------------------------------
# 2. The Legacy Way (taint)
# ---------------------------------------------------------------------------------------------------------------------
# Command 1: terraform taint aws_instance.web
# Command 2: terraform applied
# Goal: Mark it as "degraded" first, then fix it in the next apply.
