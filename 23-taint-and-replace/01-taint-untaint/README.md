# 01-taint-untaint: The Persistent Method

This example shows how to force a resource recreation using the `taint` command.

## Scenario

You applied your infrastructure. The AWS Instance is "Running".
However, the user-data script failed to install Nginx.
You need to destroy and recreate it, but you don't want to change the code.

## Steps

1.  **Create**:

    ```bash
    terraform init
    terraform apply --auto-approve
    ```

2.  **Taint (Mark for Destruction)**:
    Tell Terraform this resource is "spoiled".

    ```bash
    terraform taint aws_instance.web_server
    ```

    _Note_: This modifies `terraform.tfstate` immediately.

3.  **Plan**:

    ```bash
    terraform plan
    ```

    _Output_: `-/+ destroy and then create replacement`

4.  **Untaint (Undo)**:
    If you change your mind:
    ```bash
    terraform untaint aws_instance.web_server
    ```

## When to use?

- When the degradation is permanent and needs to be fixed by the next person running apply.
