# 03-ec2-import-scenario: The Real World

Importing an S3 bucket is easy. Importing an EC2 instance requires handling more attributes (AMI, Instance Type, Subnet, etc.). Terraform's `generate-config-out` feature shines here.

## Scenario

A rogue developer launched an EC2 instance manually. You need to manage it with Terraform.

## Steps (LocalStack)

1.  **Launch the Rogue Instance**:
    Run this command in your terminal to create a manual instance:

    ```bash
    aws --endpoint-url=http://localhost:4566 ec2 run-instances \
        --image-id ami-df5de72ade3b \
        --instance-type t3.micro \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=RogueServer}]'
    ```

2.  **Get the ID**:
    Look at the JSON output from step 1. Find the `"InstanceId"`.
    It will look like `i-1234567890abcdef0`.

3.  **Update `main.tf`**:
    Open `main.tf` and Paste that ID into the `import {}` block.

4.  **Generate Config**:

    ```bash
    terraform init
    terraform plan -generate-config-out=generated.tf
    ```

5.  **Review & Apply**:
    Open `generated.tf`. See how Terraform captured the AMI id (`ami-df5de72ade3b`) and instance type (`t3.micro`) automatically?
    ```bash
    terraform apply --auto-approve
    ```
