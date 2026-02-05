# 03-multi-account: Cross-Account Deployments

This example demonstrates how to deploy resources to **different AWS Accounts** (e.g., specific Production vs Development accounts) using the same Terraform configuration.

## The Concept

In large organizations, resources are split across accounts for security checks.
You can use `provider aliases` combined with AWS Profiles or IAM Roles to manage this.

## Code Analysis

```hcl
provider "aws" {
  alias   = "prod"
  profile = "my-prod-profile" # Defined in ~/.aws/credentials
}

resource "aws_s3_bucket" "prod_data" {
  provider = aws.prod
  bucket   = "..."
}
```

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
3.  **Verify**:
    LocalStack doesn't strictly enforce account boundaries in the community edition, but you will see the resources created successfully with the simulated concept.
