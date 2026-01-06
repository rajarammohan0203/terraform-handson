# Special Values: Null

`null` is a special value in Terraform representing "absence of a value".

## The Use Case: Optional Arguments
Sometimes you want to let the cloud provider pick a default, or you want to omit an optional configuration block.

*   **If you pass a string**: Terraform enforces that value.
*   **If you pass `null`**: Terraform acts as if you didn't write the argument at all.

## Real-World Example: Availability Zones
When creating a Subnet:
*   If you specify `availability_zone = "us-east-1a"`, it goes there.
*   If you set `availability_zone = null`, AWS picks a random zone for you.

This allows you to write one generic resource block that supports both behaviors!

## 🛠 How to Test

1.  **Init**:
    ```bash
    terraform init
    ```

2.  **Plan (Default = Null)**:
    ```bash
    terraform plan
    ```
    *   Note that `availability_zone` is known after apply (computed), because AWS picks it.

3.  **Plan (Specific Value)**:
    ```bash
    terraform plan -var='availability_zone=us-east-1a'
    ```
    *   Note that `availability_zone` is now forced to `us-east-1a`.

## 📝 Practice

Open `practice.tf` and try the exercise to conditionally handle an EC2 Key Pair name.
