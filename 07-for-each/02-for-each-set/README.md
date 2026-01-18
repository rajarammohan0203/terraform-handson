# for_each: Set Iteration (Iterate Lists Safely)

Use `for_each` with `toset()` instead of `count` for creating resources from lists.

## ☠️ The Danger of `count` on Lists

If you use `count`, Terraform identifies resources by **Index** (`[0]`, `[1]`).
If you remove item #1, everything after it shifts positions.
Terraform sees this as "Destroy resource #1, Destroy resource #2, Create new resource #2...".
**This destroys your data.**

## ✅ The Solution: `for_each = toset(list)`

Terraform identifies resources by **Value** (`["logs"]`, `["backup"]`).
If you remove "logs", Terraform deletes ONLY that bucket. The others are untouched.

## 🌍 Real-World AWS Scenario

### 1. Environment Buckets (S3)

You have a list `["dev", "stage", "prod"]`. You create 3 S3 buckets.
Using `for_each` safeguards them so deleting one doesn't force a recreate of others.

### 2. IAM Users Coverage (New!)

You have a simple list of employees `["alice", "bob"]`. You want to create a standard IAM user for each.
`for_each = toset(var.user_names)` is the perfect tool for this unique list of names.

## 🧪 How to Test

### 1. Initialize & Apply

```bash
terraform init
terraform apply --auto-approve
```

### 2. Verify with LocalStack (AWS CLI)

Check if the **S3 Buckets** were created:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
# OR if you have awslocal installed:
awslocal s3 ls
```

Check if the **IAM Users** were created:

```bash
aws --endpoint-url=http://localhost:4566 iam list-users
# OR
awslocal iam list-users
```

### 3. Verify Stability

1.  Remove "alice" from `variables.tf`.
2.  `terraform apply`.
3.  Notice Terraform **ONLY** destroys alice. It does not touch Bob or Charlie.
