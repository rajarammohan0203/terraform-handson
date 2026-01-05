# 🐳 LocalStack Guide for Safer Testing

This repository is configured to work with **LocalStack**, allowing you to emulate AWS locally and free of charge.

## 🚀 1. Start LocalStack
Run this command in the root of the repository:
```bash
docker-compose up -d
```
Verify it is running:
```bash
docker ps
# You should see 'localstack/localstack' running on port 4566
```

## 🔌 2. Configure Terraform
To use LocalStack instead of real AWS, you must configure the `aws` provider to talk to localhost.

**Copy the `localstack_provider_override.tf` file from the `templates/` folder into any exercise folder you are working on.**

Example content of the override:
```hcl
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}
```

## 🧪 3. Verification
Once configured, run Terraform as usual:
```bash
terraform init
terraform apply
```

To see the resources you created, use `awslocal` (if installed) or AWS CLI with endpoint:
```bash
aws --endpoint-url=http://localhost:4566 s3 ls

> **Note**: If you get a credential error, use dummy keys:
> `AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test aws --endpoint-url=http://localhost:4566 s3 ls`
```

## 🛑 4. Cleanup
To stop LocalStack:
```bash
docker-compose down
```
