# Practical: Creating Your First EC2 Instance ☁️

This exercise demonstrates how to create a basic compute resource (EC2) using Terraform and LocalStack.

## 📋 Prerequisites
1.  **LocalStack Running**: Ensure Docker is up (`docker ps` should show port 4566).
2.  **Terraform Installed**: `terraform version`.

## 🛠️ Files in this Folder
-   `provider.tf`: Configures Terraform to talk to LocalStack (localhost:4566).
-   `main.tf`: Defines the AWS Instance resource.

## 🚀 Step-by-Step Instructions

### Step 1: Initialize
Download the provider plugins. Since we are using LocalStack, this is just the standard AWS provider.
```bash
terraform init
```

### Step 2: Validate
Check if the code is syntactically correct.
```bash
terraform validate
```

### Step 3: Plan
Preview the changes. Terraform will calculate what needs to be created.
```bash
terraform plan
```
*Look for `+ create` in the output.*

### Step 4: Apply
Create the resource in LocalStack.
```bash
terraform apply -auto-approve
```

### Step 5: Verify
Use the AWS CLI (pointed to LocalStack) to see your server.
```bash
AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
Update-aws-credentials --profile localstack --access-key test --secret-key test

aws --profile localstack --endpoint-url=http://localhost:4566 ec2 describe-instances --region us-east-1
```

### Step 6: Destroy
Clean up the resource.
```bash
terraform destroy -auto-approve
```
