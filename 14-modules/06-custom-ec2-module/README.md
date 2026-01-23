# 06-custom-ec2-module: Composition Pattern

This example demonstrates the **Composition Pattern**, where a root module ties together multiple smaller, reusable modules (`networking` and `compute`) to create a complete solution.

## Architecture

1.  **`networking` Module**: Creates the VPC, Public Subnet, Internet Gateway, and Route Table.
2.  **`compute` Module**: Creates the EC2 Instance and Security Group.
3.  **App Logic**: The Root Module passes the `vpc_id` and `subnet_id` from Networking -> Compute.

## The Power of Modules

- **Reusability**: You can reuse the `networking` module for a completely different project.
- **Isolation**: Changes to `compute` tags don't risk breaking the VPC CIDR.
- **Readability**: The root `main.tf` is just 10 lines of code, verifying the high-level architecture.

## Quick Start

1.  **Initialize**:
    ```bash
    terraform init
    ```
2.  **Start LocalStack** (Critical Step):
    Ensure your LocalStack container is running.
    ```bash
    curl http://localhost:4566/_localstack/health
    ```
3.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
4.  **Verify**:
    ```bash
    # Check the Instance
    aws --endpoint-url=http://localhost:4566 ec2 describe-instances --filters "Name=tag:Name,Values=dev-app-server"
    ```
