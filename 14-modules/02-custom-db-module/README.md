# 02-custom-db-module: The Power of Encapsulation

This example demonstrates how to build a **Production-Ready Module**.
In a real scenario, this would be an **RDS Instance**, but since **LocalStack Community** does not support RDS, we are using **DynamoDB** to demonstrate the exact same "Encapsulation" principles.

## The Concept

As a DevOps Engineer, you want to provide a "Golden Path" for developers.
They shouldn't need to know about:

- Billing Modes
- Hash Keys / Range Keys
- Tagging Standards
- SSM Parameter Registration

They just want a **Database**.

This module bundles:

1.  **DynamoDB Table**: The actual storage.
2.  **SSM Parameter**: A configuration entry so apps can find the table name.

## Quick Start

1.  **Initialize**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
3.  **Verify**:

    ```bash
    # List Tables
    aws --endpoint-url=http://localhost:4566 dynamodb list-tables

    # Check the SSM Config
    aws --endpoint-url=http://localhost:4566 ssm get-parameter --name "/app/marketing-users-db/config"
    ```

You will see the table `marketing-users-db` and the SSM parameter created automatically.
