# 01-required-providers: Version Pinning

This example demonstrates **Golden Rule #1 of Production Terraform**: Always Pin Your Provider Versions.

## Why?

Providers (like `hashicorp/aws`) release updates frequently.

- **Minor Updates (5.1 -> 5.2)**: New features, bug fixes. Safe.
- **Major Updates (5.x -> 6.0)**: **BREAKING CHANGES**. Resources might be deleted or arguments renamed.

If you don't pin the version, `terraform init` will download the _latest_ version. If a new major version was released last night, your production deployment could break this morning.

## Analysis: `provider.tf`

```hcl
required_providers {
  aws = {
    version = "~> 5.0" # SAFE: Allow 5.1, 5.9, but BLOCK 6.0
  }
  random = {
    version = "3.6.0"  # STRICT: Only allow exactly 3.6.0
  }
}
```

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
    Notice the output: `Installing hashicorp/aws v5.x.x...`
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
