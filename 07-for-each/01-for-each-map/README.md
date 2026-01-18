# for_each: Map Iteration

Use `for_each` when you have a Map of unique items that need specific inputs.

## 🌍 Real-World AWS Scenario

**IAM User Management**:
You have 10 employees. You can't just Loop `count=10` because each employee has a different name, different department tag, and different permissions.

**The Solution**:
Use `for_each` on a Map:

```hcl
variable "users" {
  default = {
    alice = { dept = "dev" }
    bob   = { dept = "sales" }
  }
}
```

In the resource, `each.key` gives you "alice", and `each.value.dept` gives you "dev".

## 🧪 How to Test

### 1. Initialize & Apply

```bash
terraform init
terraform apply --auto-approve
```

### 2. Inspect State

```bash
terraform state list
```

**Result**: You will see resources named by their KEYS:

- `aws_iam_user.users["alice"]`
- `aws_iam_user.users["bob"]`
- `aws_iam_user.users["charlie"]`

(Unlike `count` which produces `[0]`, `[1]`, `[2]`).

### 3. Add a User

Edit `variables.tf` and add "david".
Apply again. Notice how safe and clean the addition is.
