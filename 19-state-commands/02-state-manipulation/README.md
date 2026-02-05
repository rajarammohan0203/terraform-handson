# 02-state-manipulation: Surgical Operations

This example demonstrates how to Modify the State File manually using `mv` and `rm`.

## Scenario 1: Renaming without Destroying (Move)

1.  **Create Resource**:

    ```bash
    terraform init && terraform apply --auto-approve
    ```

    This creates `random_pet.database`.

2.  **Refactor Code**:
    Open `main.tf` and change:
    `resource "random_pet" "database"` -> `resource "random_pet" "production_db"`.

3.  **The Problem**:
    Run `terraform plan`.
    Terraform says: "Plan: 1 to add, 1 to destroy". **THIS IS BAD**.
    It wants to delete your database and make a new one!

4.  **The Fix (`state mv`)**:
    Tell Terraform they are the same thing:

    ```bash
    terraform state mv random_pet.database random_pet.production_db
    ```

5.  **Verify**:
    Run `terraform plan`.
    Result: `No changes. Your infrastructure matches the configuration.` (Success!)

## Scenario 2: Stopping Management (Remove)

1.  You want Terraform to stop managing this resource, but **keep it running in AWS**.
2.  Run:
    ```bash
    terraform state rm random_pet.production_db
    ```
3.  Delete the code block from `main.tf`.
4.  Run `terraform plan`.
    Result: `No changes.` (Terraform forgot about it, so it won't try to destroy it).
