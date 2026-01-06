# Collections vs Structural: Map vs Object

In Terraform, both `map` and `object` look like JSON objects (key-value pairs), but they serve different purposes.

## The Comparison

| Feature | Map `map(type)` | Object `object({ attr = type })` |
| :--- | :--- | :--- |
| **Value Types** | **Uniform**. Must be ALL strings or ALL numbers. | **Mixed**. Can have string, number, bool, etc. |
| **Keys** | Arbitrary. You can add any key dynamically. | **Fixed**. You must define exact attribute names in schema. |
| **Use Case** | Tags, Environment Variables, lookup tables. | Configuration structs (e.g., Instance Config, Database Settings). |

## Real-World Example

### 1. Variables (Tags -> Map)
We use a **Map** for tags because tags are always `string=string`. We might want to add arbitrary tags later without changing the variable definition.

### 2. Configuration (Instance -> Object)
We use an **Object** for the instance config because we need:
*   `ami` (string)
*   `volume_size` (number)
*   `monitoring` (bool)

A map cannot support this mix of types!

## 🛠 How to Test

1.  **Init & Plan**:
    ```bash
    terraform init
    terraform plan
    ```
    *   Observe how the `aws_instance` pulls values from the `object` (ami, type) and the `map` (tags).

2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```

## 📝 Practice

Open `practice.tf` and try the exercises for S3 Bucket Tags (Map) and Lifecycle Rules (Object).
