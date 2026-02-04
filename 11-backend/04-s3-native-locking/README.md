# 04-s3-native-locking: The Modern Way

This example demonstrates the **newest** way to handle state locking, available in Terraform v1.10+.

## The "New" Feature: `use_lockfile = true`

Historically, S3 was "Eventually Consistent" and didn't support safe locking, so we needed DynamoDB.
Recently, AWS updated S3 to be "Strongly Consistent" and support "Conditional Writes".

Terraform now leverages this! You just add `use_lockfile = true` and you get safety **without** managing a DynamoDB table.

## Setup Instructions (LocalStack)

1.  **Create Bucket**:

    ```bash
    aws --endpoint-url=http://localhost:4566 s3 mb s3://my-terraform-state-bucket
    ```

    (Any S3 Standard bucket works).

2.  **Init & Apply**:
    ```bash
    terraform init
    terraform apply --auto-approve
    ```

## Verify

This is harder to "see", but you can check that you _didn't_ provide a DynamoDB table name, yet Terraform didn't complain about unsafe state!
Note: LocalStack support for the specific `PutObject` conditional write extensions used by `use_lockfile` might vary by version, but this is the correct syntax for real AWS.
