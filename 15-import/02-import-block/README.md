# 02-import-block: The Modern Way

This example demonstrates declarative import using the `import {}` block (Terraform v1.5+).

## The Wizardry

Instead of writing HCL code matching the existing infrastructure, Terraform **generates** it for you.

## Steps (LocalStack)

1.  **Create the "Existing" Resource**:

    ```bash
    aws --endpoint-url=http://localhost:4566 s3 mb s3://my-manual-bucket-for-block
    ```

2.  **Inspect Code**:
    Look at `main.tf`. We have an `import {}` block but NO `resource {}` block.

3.  **Generate Code**:

    ```bash
    terraform init
    terraform plan -generate-config-out=generated.tf
    ```

4.  **Magic**:
    Open the newly created `generated.tf` file. Terraform has written the `resource "aws_s3_bucket" ...` block for you!

5.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
