# Terraform Primitive Types

In Terraform, the most basic data types are **Primitives**. These represent single values.

## The 3 Primitives

1.  **`string`**: Text values.
    *   **Real World Use**: AMI IDs (`"ami-0c55..."`), Instance Types (`"t2.micro"`), Names.

2.  **`number`**: Numeric values.
    *   **Real World Use**: `count` (how many instances), Port numbers (`80`, `443`), Disk size (`20` GB).

3.  **`bool`**: True/False logic.
    *   **Real World Use**: `associate_public_ip_address` (true/false), `monitoring` enabled, `encrypted`.

## 🛠 How to Test

1.  **Initialize**:
    ```bash
    terraform init
    ```

2.  **Plan** (See the values):
    ```bash
    terraform plan
    ```
    *   Look at the `Changes to Outputs` section to see your values printed.

3.  **Experiment**:
    *   Open `main.tf` and change the math logic.
    *   Open `terraform.tfvars` and change the input values.
    *   Run `terraform plan` again to see the difference.

## 📝 Practice

Open `practice.tf`. You will find commented-out exercises.
1.  Uncomment the blocks.
2.  Fill in the missing code (`...`).
3.  Run `terraform plan` to verify your work!