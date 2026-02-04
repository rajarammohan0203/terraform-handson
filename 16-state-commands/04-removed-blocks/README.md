# 04-removed-blocks: Declarative Removal

This example demonstrates the modern way to stop managing resources without destroying them (Terraform v1.7+).

## The Old Way (`state rm`)

In folder `02`, you learned `terraform state rm`. That is **Imperative** (a command you run once). It is risky because it's not version-controlled.

## The New Way (`removed {}`)

You can write code that says "I am intentionally removing this from Terraform".

## Steps

1.  **Create Resource**:
    Uncomment the `resource` block in `main.tf`.

    ```bash
    terraform init && terraform apply --auto-approve
    ```

2.  **Declare Removal**:
    - **Comment out** the `resource` block.
    - **Uncomment** the `removed {}` block.

3.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
    _Result_: Terraform will say: `Resource random_pet.database has been removed from the state.`
    But `destroy = false` means the actual resource (the pet name) is NOT destroyed.

## Why use this?

It provides a **Git History** record of exactly when and why you stopped managing a resource.
