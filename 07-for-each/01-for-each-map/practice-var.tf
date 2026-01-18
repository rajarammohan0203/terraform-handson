# PRACTICE CHALLENGE
# 1. Run `terraform apply` to create the 3 users.
# 2. Add a NEW user "david" to the `variables.tf` default map.
#    "david" = { department = "hr", is_admin = false }
# 3. Run `terraform apply`.
# 4. OBSERVE: Terraform create ONLY "david". It does not touch alice, bob, or charlie.
#    (If you used `count` and inserted david at the top, it would recreate everyone!)
