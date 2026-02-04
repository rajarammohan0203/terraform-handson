# 01-sensitive-parameters: Masking Inputs

This example demonstrates how to prevent sensitive values (passwords, tokens) from being displayed in plain text during `terraform plan` and `terraform apply`.

## The Problem

By default, Terraform displays all variable values in the CLI output. This means your CI/CD logs might expose your database password to anyone who can read the logs.

## The Solution: `sensitive = true`

1.  **Variables**: Mark the input variable as sensitive.
    ```hcl
    variable "password" {
      sensitive = true
    }
    ```
2.  **Outputs**: Mark the output as sensitive.
    ```hcl
    output "db_pass" {
      value     = var.password
      sensitive = true
    }
    ```

## Effect

Terraform will replace the value with `(sensitive value)` in the console output.

**WARNING**: The value is **STILL VISIBLE** in the `terraform.tfstate` file! "Sensitive" only masks the UI output.

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
    Observe that the `connection_string` output is hidden.
