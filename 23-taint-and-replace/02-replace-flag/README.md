# 02-replace-flag: The Modern Method

This example shows how to use the `-replace` flag during apply.

## Scenario

You want to rotate the database password (`random_password`).
If you just run `apply`, Terraform sees no changes.
You _could_ taint it, but that modifies the state file permanently until applied.

## The Solution: `-replace`

This flag tells Terraform: "For THIS RUN ONLY, pretend this resource doesn't exist".

## Steps

1.  **Create**:

    ```bash
    terraform init
    terraform apply --auto-approve
    ```

2.  **Force Rotation**:

    ```bash
    terraform apply -replace="random_password.db_password"
    ```

3.  **Result**:
    Terraform destroys the old password, creates a new one, and updates the SSM parameter (cascade update).

## Why is this better than Taint?

- **Atomic**: It happens in one command.
- **Safe**: If the apply fails or you cancel it, the state is NOT left in a "tainted" state.
