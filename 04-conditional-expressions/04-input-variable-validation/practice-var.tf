# PRACTICE CHALLENGE
# 1. Apply the code with defaults (it will work).
# 2. Run this command to FAIL validation:
#    terraform plan -var="environment=uat"
#    
#    OBSERVE ERROR:
#    "Environment must be one of: dev, staging, prod."

# 3. Run this command to FAIL validation:
#    terraform plan -var="ami_id=invalid-ami"
#    
#    OBSERVE ERROR:
#    "AMI ID must start with 'ami-'..."
