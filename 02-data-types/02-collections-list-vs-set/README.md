# Collections: List vs Set

This folder demonstrates the critical difference between **List** and **Set** using real AWS scenarios.

## 1. List `[...]`: Security Group Rules
**Scenario**: You want to allow traffic from a list of IP addresses.
**Why List?**
*   Arguments like `cidr_blocks` in security groups **expect** a list.
*   We can pass the variable directly: `cidr_blocks = var.allowed_ips`.
*   **Order**: Lists preserve order (Index 0 is always Index 0).

## 2. Set `[...]`: IAM Users
**Scenario**: You want to create multiple user accounts.
**Why Set?**
*   **Uniqueness**: You cannot have two users with the same name. Sets automatically remove duplicates (e.g., `["alice", "alice"]` -> `["alice"]`).
*   **Looping**: Since there is no single "Create Users" resource that takes a list, we use a loop (`for_each`) to create one user per item in the set.

## 🛠 Limitations & When to Use

| Type | Limitation | Best For |
| :--- | :--- | :--- |
| **List** | If you delete item #0, item #1 becomes #0. This shift can force resources to be destroyed and recreated if you use `count`. | Ordered data, arguments expecting `[]`, passing multiple values to one config. |
| **Set** | No order (you can't say "give me the first user"). | Unique collections, iterating with `for_each` to create independent resources. |

## 🧪 How to Verify (Step-by-Step)

1.  **Initialize**:
    ```bash
    terraform init
    ```

2.  **Plan**:
    ```bash
    terraform plan
    ```
    *   **Observe Lists**: See how `cidr_blocks` takes the list `["10.0.1.0/24", ...]`.
    *   **Observe Sets**: Note that `alice` appears only ONCE in the plan, even though we listed her twice in `variables.tf`.

3.  **Apply (LocalStack)**:
    ```bash
    terraform apply --auto-approve
    ```

4.  **Verify Endpoints**:
    *   **List (Firewall)**:
        ```bash
        aws --endpoint-url=http://localhost:4566 ec2 describe-security-groups
        ```
        *Look for the IpPermissions with your IP ranges.*
    *   **Set (Users)**:
        ```bash
        aws --endpoint-url=http://localhost:4566 iam list-users
        ```
        *Confirm 'alice' is listed only once.*

5.  **Destroy**:
    ```bash
    terraform destroy --auto-approve
    ```

## 📝 Testing Your Practice Exercises

After completing the exercises in `practice.tf`, you can test them:

1.  **Validate Your Code**:
    ```bash
    terraform validate
    ```
    *This checks for syntax errors.*

2.  **Format Your Code**:
    ```bash
    terraform fmt
    ```
    *This auto-formats your `.tf` files.*

3.  **Plan with Practice Variables**:
    ```bash
    terraform plan
    ```
    *Your new variables (`zones`, `bucket_names`) will be included in the plan.*

4.  **Apply (if you added resources)**:
    If you added resources using your practice variables in `real_world_example.tf`:
    ```bash
    terraform apply --auto-approve
    ```

5.  **Verify Your Practice Resources**:
    *   **For S3 Buckets** (if you created them):
        ```bash
        aws --endpoint-url=http://localhost:4566 s3 ls
        ```
    *   **For Subnets** (if you created them):
        ```bash
        aws --endpoint-url=http://localhost:4566 ec2 describe-subnets
        ```

6.  **Clean Up**:
    ```bash
    terraform destroy --auto-approve
    ```
