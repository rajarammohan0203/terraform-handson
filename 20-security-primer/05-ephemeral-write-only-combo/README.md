# 05-ephemeral-write-only-combo: The Zero-Trace Database

This is the **Holy Grail** of Terraform Security.

## The Objective

Create a Database with a random, strong password, BUT ensure that password **NEVER** touches the disk.

- Not in `variables.tf`
- Not in `terraform.tfvars`
- Not in `terraform.tfstate` (The most common leak!)

## The Mechanics

We combine two advanced features:

1.  **`ephemeral "random_password"`**:
    - Tell Terraform: "Generate this resource, use it, but **DO NOT** save it to the state file."
    - The password exists in RAM only for the duration of the `apply`.

2.  **Pass to `aws_db_instance` (Write-Only Pattern)**:
    - `password_wo`: The Write-Only argument. Terraform sends it to AWS but treats it as strictly one-way.
    - `password_wo_version = 1`: A helper argument. If you need to rotate the password later, you change this to `2`. This signals Terraform to re-send the (new) ephemeral password, even though it can't "read" the old one to compare.

## Outcome

1.  **State File Checks**: If you open `terraform.tfstate`, you will check the `aws_db_instance`.
    - You will see `username`: "admin".
    - You will see `password`: **(null)** or hidden?
    - _Crucially_: The `random_password` resource itself is **NOT IN THE STATE FILE AT ALL**.

## Requirements

- Terraform v1.10+
- Providers that support ephemeral protocols.

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
3.  **Inspect State**:
    ```bash
    cat terraform.tfstate | grep "password"
    ```
    (You should find NO traces of the actual secret string).
