# 01-local-backend: The Default

This example demonstrates the default **Local Backend**.

## How it works

When you run `terraform apply`, Terraform creates a file named `terraform.tfstate` in your current directory.

## Pros & Cons

- **Pros**: Zero configuration. Easy for learning.
- **Cons**:
  - **No Collaboration**: If your teammate runs this, they have their OWN state file. You describe the same AWS resources but Terraform thinks they are different.
  - **Security**: Secrets in local plain text file on your laptop.
  - **Risk**: If you lose your laptop, `terraform.tfstate` is gone, and Terraform loses track of your infrastructure.

## Quick Start

1.  **Init & Apply**:
    ```bash
    terraform init
    terraform apply --auto-approve
    ```
2.  **Inspect**:
    Look at the `terraform.tfstate` file created in this directory.
