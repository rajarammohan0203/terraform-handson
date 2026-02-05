# PRACTICE CHALLENGE
# 1. Apply the code with `terraform apply`.
# 2. Go to AWS Console (or use CLI) and ADD a tag to this instance: `ManualTag = True`.
#    (For LocalStack: `awslocal ec2 create-tags --resources <ID> --tags Key=Manual,Value=True`)
# 3. Run `terraform plan`.
# 4. OBSERVE: Terraform says "No Changes". It ignores the drift in tags.
# 5. Comment out `ignore_changes` and run plan again. Terraform will want to REMOVE your manual tag.
