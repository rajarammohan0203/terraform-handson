# 02-s3-standard-backend: Remote State

This example demonstrates how to store your state file in an **S3 Bucket** instead of your local laptop.

## The Chicken and Egg Problem

You cannot use Terraform to create the bucket that Terraform uses to store its state (at least not in the same step).
**You must create the backend bucket MANUALLY first.**

## Setup Instructions (LocalStack)

1.  **Create the Backend Bucket manualy**:

    ```bash
    aws --endpoint-url=http://localhost:4566 s3 mb s3://my-terraform-state-bucket
    ```

2.  **Initialize Terraform**:

    ```bash
    terraform init
    ```

    (This connects to the bucket you just created).

3.  **Apply**:

    ```bash
    terraform apply --auto-approve
    ```

4.  **Verify**:
    Check if the state file exists in S3:
    ```bash
    aws --endpoint-url=http://localhost:4566 s3 ls s3://my-terraform-state-bucket/dev/
    ```

## Why?

- **Collaboration**: Now your whole team can access the state.
- **Safety**: S3 (in real life) supports Versioning, so you can rollback state files.
