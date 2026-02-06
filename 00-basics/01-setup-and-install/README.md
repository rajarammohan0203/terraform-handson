# Setup and Install

## Goal

Verify that your environment is ready for Terraform development.

## Prerequisites

1. **Terraform**: `terraform version` should show v1.5+
2. **AWS CLI**: `aws --version` should show v2+
3. **LocalStack**: (install from https://docs.localstack.cloud/get-started/installation/) or use docker to install localstack

## 🐳 Running with LocalStack (Recommended)

This repository is configured for **LocalStack** to save costs.

1. Go to the root of the repo:
   ```bash
   cd ../../
   docker-compose up -d
   ```
2. Verify it is running: `docker ps`
3. In every future exercise, copy `templates/localstack_provider_override.tf` into your folder.

## 📝 Check your version

```bash
terraform version
```

## AWS Local Stack

https://docs.localstack.cloud/aws/services/
