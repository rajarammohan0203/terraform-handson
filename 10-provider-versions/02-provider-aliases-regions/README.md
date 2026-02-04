# 02-provider-aliases-regions: Multi-Region Deployments

This example demonstrates how to deploy resources to **multiple AWS regions** in a single `terraform apply`.

## The Concept

By default, Terraform uses the `provider "aws"` block for all resources.
If you need a resource in a different region (e.g., a Disaster Recovery bucket in Europe), you must define a **Provider Alias**.

## Code Analysis

1.  **Define the Alias**:
    ```hcl
    provider "aws" {
      alias  = "europe"
      region = "eu-west-1"
    }
    ```
2.  **Use the Alias**:
    ```hcl
    resource "aws_s3_bucket" "eu_bucket" {
      provider = aws.europe
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
    ```bash
    aws --endpoint-url=http://localhost:4566 s3api get-bucket-location --bucket my-app-data-us-east-1
    aws --endpoint-url=http://localhost:4566 s3api get-bucket-location --bucket my-app-data-eu-west-1
    ```
