# Practice!
# 1. Run the replace command on the SSM parameter:
#    `terraform apply -replace="aws_ssm_parameter.secret"`
# 2. Observe: Does this recreate the password?
#    Answer: NO. The dependency goes Password -> SSM.
#    Recreating the downstream resource (SSM) does not affect the upstream (Password).
