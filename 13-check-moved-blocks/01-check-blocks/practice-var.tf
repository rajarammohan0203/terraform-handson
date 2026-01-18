# PRACTICE CHALLENGE
# 1. Run `terraform apply`.
# 2. Terraform will show: "Check block bucket_health_check: passed".
# 3. Can we make it fail?
#    Try changing the condition in `real_world_example.tf` to `== "us-west-2"`.
# 4. Run `terraform apply` again.
# 5. OBSERVE:
#    It does NOT crash. The apply succeeds.
#    But at the end, it shows a WARNING: "Check block bucket_health_check: failed".
#    This is the key difference from "precondition" (which would crash).
