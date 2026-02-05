# 02-workspaces-state-migration: Moving to the Cloud

This example demonstrates how to migrate your Local state to HCP Terraform.

## Prerequisites

1.  **Account**: Create a free account at [app.terraform.io](https://app.terraform.io).
2.  **Organization**: Create a generic organization (e.g., `test-lab-user`).
3.  **Token**: You need a CLI API token.

## Steps

1.  **Login**:
    Authenticate your CLI with HCP.

    ```bash
    terraform login
    ```

    (Follow the browser instructions to generate and paste the token).

2.  **Edit/Verify Code**:
    Open `provider.tf`.
    **UPDATE** `organization = "my-demo-org"` to match your actual Organization name.

3.  **Init (The Migration)**:

    ```bash
    terraform init
    ```

    Terraform will detect the new `cloud` block and ask:

    > Do you want to copy existing state to the new backend?
    > Type `yes`.

4.  **Run**:
    ```bash
    terraform apply
    ```
    Notice the output says "Running operation remotely in Terraform Cloud".
    The execution is happening on THEIR servers, not your laptop!

## Workspace Types

- **CLI-Driven** (What we just did): Triggered by your CLI commands.
- **VCS-Driven**: Connected to GitHub. Triggered by git commits.
- **API-Driven**: Triggered by external scripts/CI.
