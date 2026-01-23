# Terraform Modules: The Basics

Understand **Root Modules** vs **Child Modules**.

## 🧩 What is a Module?

A module is just a folder with Terraform files.

- **Root Module**: The folder where you run `terraform apply`.
- **Child Module**: A folder that you _call_ from another module.

## 🌍 Real-World Logic

Think of a Module like a **Function** in programming.

- **Variables** = Function Arguments.
- **Resources** = Function Logic.
- **Outputs** = Return Values.

Instead of writing `resource "aws_s3_bucket"` 10 times, you write it **ONCE** in a module, and call it 10 times.

## 🧪 How to Test

1.  **Initialize** (Downloads the module references):
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
3.  **Verify**:

    ```bash
    aws --endpoint-url=http://localhost:4566 s3 ls --profile localstack
    ```

    You will see both `my-app-logs-001` and `my-app-assets-001`.
