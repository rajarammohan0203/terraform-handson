# Practice!
# 1. Run `terraform plan`.
# 2. Add a new rule in variables.tf that creates 'archive/' folder.
#    - ID: "archive-rule"
#    - Transition: 90 days to "GLACIER"
#    - Expiration: Never (null)
# 3. Observe how the dynamic block handles the null expiration (it should not output an expiration block).
