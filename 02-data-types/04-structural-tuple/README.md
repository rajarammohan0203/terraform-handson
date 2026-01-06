# Structural Types: Tuple

A `tuple` is a complex structural type in Terraform. It is similar to a list, but each element can have a **different type**.

## The Definition
`tuple([string, number, bool])` means:
*   Item 0 MUST be a string.
*   Item 1 MUST be a number.
*   Item 2 MUST be a boolean.
*   The length is FIXED at 3.

## Real-World Example: Database Settings
Imagine needing to pass a compact configuration for a database module:
`["db.t3.micro", 5432, true]`

*   **Index 0**: Instance Class (`db.t3.micro`)
*   **Index 1**: Port (`5432`)
*   **Index 2**: Multi-AZ (`true`)

While concise, **Objects** are often clearer (`{ port = 5432 }` vs `[1]`). Use tuples when the order is intuitive and you want to enforce a schema of mixed types in a sequence.

## 🛠 How to Test

1.  **Init & Plan**:
    ```bash
    terraform init
    terraform plan
    ```
    *   Notice how we access values using `var.db_settings[0]`, `[1]`, etc.
    *   Check the Security Group ingress port matching the second item in the tuple.

2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```

## 📝 Practice

Open `practice.tf` and try the exercise to create a server specification tuple.
