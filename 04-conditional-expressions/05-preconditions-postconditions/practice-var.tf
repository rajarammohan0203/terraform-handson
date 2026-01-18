# PRACTICE CHALLENGE
# 1. Run `terraform apply`.
# 2. OBSERVE FAILURE (Postcondition):
#    "Volume size must be at least 10 GB..."
#    (Because default is 5 in variables.tf).
#
# 3. Fix it: Run `terraform apply -var="volume_size=15"`
#    (It should succeed).
#
# 4. Fail Precondition:
#    `terraform apply -var="instance_type=m5.large"`
#    ERROR: "This Application only supports T2 instance types."
