# 01-state-list-show: Inspecting the Matrix

This example demonstrates how to find resources in your Terraform State.

## Scenario

You have complex infrastructure with loops (`count`, `for_each`) and modules.
You need to find the specific **ID** of the "editor" user role.

## Steps

1.  **Create Resources**:

    ```bash
    terraform init
    terraform apply --auto-approve
    ```

2.  **List All Resources**:

    ```bash
    terraform state list
    ```

    _Output_:

    ```
    random_pet.server_names[0]
    random_pet.server_names[1]
    random_pet.user_roles["admin"]
    module.vpc.random_id.network_id
    ...
    ```

3.  **Inspect a Specific Resource**:
    Copy one of the names from the list above (e.g., `random_pet.user_roles["editor"]`).
    ```bash
    terraform state show 'random_pet.user_roles["editor"]'
    ```
    _Result_: You see all attributes (id, length, prefix) of that specific resource.
    **Note**: You must use single quotes `'` around names with brackets `[]` in zsh/bash!
