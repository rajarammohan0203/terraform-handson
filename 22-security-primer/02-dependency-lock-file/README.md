# 02-dependency-lock-file: Provider Integrity

This example explains the importance of the `.terraform.lock.hcl` file.

## What is it?

When you run `terraform init`, Terraform downloads provider plugins (executables) to `.terraform/providers`.
It ALSO creates `.terraform.lock.hcl`.

This lock file contains the **Crypto Hashes** (checksums) of the plugins you downloaded.

## Why is it a Security Feature?

Imagine a hacker compromises the `hashicorp/random` provider on the internet and replaces it with a malicious version.

- **Without Lock File**: Your CI/CD downloads the new (malicious) version and runs it. You are compromised.
- **With Lock File**: Terraform checks the hash of the downloaded plugin vs the hash in the lock file. **They don't match -> Terraform aborts.**

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
2.  **Inspect**:
    Open the generated `.terraform.lock.hcl` file. You will see something like:
    ```hcl
    provider "registry.terraform.io/hashicorp/random" {
      version     = "3.6.0"
      constraints = "3.6.0"
      hashes = [
        "h1:...",
        "zh:...",
      ]
    }
    ```
