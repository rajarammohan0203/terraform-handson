# 03-dynamodb-locking: State Locking

This example demonstrates the "Standard Enterprise" way to lock state files using DynamoDB.

## The Problem

If Developer A runs `terraform apply` (taking 10 minutes) and Developer B runs `terraform apply` 1 minute later:

- Without locking: B overwrites A's work or corrupts the state file.
- **With locking**: B gets an error: `Error acquiring the state lock`.

## Setup Instructions (LocalStack)

You need **TWO** things before running this:

1.  **State Bucket** (S3).
2.  **Lock Table** (DynamoDB) with a Partition Key named `LockID`.

```bash
# 1. Create Bucket
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-terraform-state-bucket

# 2. Create Lock Table
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
    --table-name terraform-lock-table \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

## Quick Start

1.  **Init**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```

## Verify Locking

If you were fast enough (or used a `local-exec` sleep), and tried to run a second apply in another terminal, you would see the Lock Error. Use `terraform force-unlock <ID>` if it gets stuck!
