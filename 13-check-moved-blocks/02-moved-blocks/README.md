# Moved Blocks (State Refactoring)

Rename resources in your code **without** destroying the actual infrastructure.

## ☠️ The Refactoring Problem
If you change a resource name in `.tf` files:
`resource "aws_instance" "old"`  --> `resource "aws_instance" "new"`

Terraform interprets this as:
1.  **Delete** `aws_instance.old`.
2.  **Create** `aws_instance.new`.

This causes **Downtime** and **Data Loss**.

## ✅ The Solution: `moved` block
Available in Terraform v1.1+.
It documents the rename so Terraform updates the State File instead of the Cloud Infrastructure.

```hcl
moved {
  from = aws_instance.old
  to   = aws_instance.new
}
```

## 🧪 How to Test (LocalStack)

### 1. Verification Command
To verify your bucket exists before and after the move without change:
```bash
awslocal s3 ls
```

### 2. Follow Usage Guide
Open `practice-var.tf` and follow Step 1, 2, and 3.
You will see the magic moment where `terraform plan` says **"Resource has moved"** instead of "Destroy/Create".
