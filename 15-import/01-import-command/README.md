# 01-import-command: The Classic Way

This example demonstrates how to import existing infrastructure using the `terraform import` CLI command.

## The Scenario

You manually created an S3 bucket named `my-manual-bucket`. Now you want Terraform to manage it.

## Steps (LocalStack)

1.  **Create the "Existing" Resource**:
    We need to simulate the manual resource first.

    ```bash
    aws --endpoint-url=http://localhost:4566 s3 mb s3://my-manual-bucket
    ```

2.  **Write code (I did this for you)**:
    We added `resource "aws_s3_bucket" "imported_bucket" {}` to `main.tf`.

3.  **Run `terraform import`**:
    This maps the real-world ID (`my-manual-bucket`) to the Terraform Resource (`aws_s3_bucket.imported_bucket`).

    ```bash
    terraform init
    terraform import aws_s3_bucket.imported_bucket my-manual-bucket
    ```

4.  **Verify**:
    ```bash
    terraform plan
    ```
    Result: `No changes. Your infrastructure matches the configuration.`
    (If we hadn't imported it, Terraform would try to create a NEW bucket and fail with "BucketAlreadyExists").
