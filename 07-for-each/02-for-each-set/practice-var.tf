# PRACTICE CHALLENGE
# 1. Apply the code.
# 2. Open `variables.tf` and REMOVE "assets" from the list.
# 3. Add "metrics" to the list.
# 4. Run `terraform apply`.
# 5. OBSERVE:
#    Terraform will:
#    - Destroy ONLY "assets" bucket.
#    - Create ONLY "metrics" bucket.
#    - Leave "logs" and "backups" completely untouched.
#    (This proves the stability of Set keys vs Count indexes).
