# 03-cross-project-remote-data: Collaboration

This example shows how "Team A" shares data with "Team B" without Copy-Pasting hardcoded IDs.

## The Concept

**`data "terraform_remote_state"`**: A read-only interface to _another_ Terraform project's state file.

## Scenario

1.  **Layer 1 (Network Team)**: Creates a VPC and Subnet. Outputs the IDs.
2.  **Layer 2 (App Team)**: Needs that Subnet ID to launch an EC2 instance.

## One-Time Setup (Important!)

You must run Layer 1 FIRST, because Layer 2 cannot read a state file that doesn't exist.

1.  **Deploy Layer 1**:

    ```bash
    cd layer1-network
    terraform init
    terraform apply --auto-approve
    ```

    (This creates `layer1-network/terraform.tfstate`).

2.  **Deploy Layer 2**:
    ```bash
    cd ../layer2-app
    terraform init
    terraform apply --auto-approve
    ```
    Observe how `aws_instance` automatically picked up the `subnet_id` from Layer 1!
