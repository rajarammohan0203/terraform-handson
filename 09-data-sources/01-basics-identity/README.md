# Data Sources: Identity & Context

**Data Sources** allow Terraform to **READ** information from the cloud.
Think of them as "ReadOnly Variables" that come from AWS, not from you.

| Data Source              | Question it Answers    | Example Output                                      |
| :----------------------- | :--------------------- | :-------------------------------------------------- |
| `aws_caller_identity`    | **Who am I?**          | Account ID: `123456789012`, ARN: `arn:aws:iam::...` |
| `aws_region`             | **Where am I?**        | Name: `us-east-1`                                   |
| `aws_availability_zones` | **What is available?** | List: `["us-east-1a", "us-east-1b"]`                |

## 🌍 Real-World AWS Scenario

**The Problem:**
You need to create an S3 bucket with a **Globally Unique** name.
Naming it `my-logs` is risky (someone else might have taken it).

**The Solution:**
Append your AWS Account ID to the name. It's unique to you!
You don't want to hardcode it (it changes per environment). Fetch it dynamically.

```hcl
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "b" {
  bucket = "logs-${data.aws_caller_identity.current.account_id}"
}
```

## 🧪 How to Test

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- The S3 bucket name includes `000000000000` (LocalStack's default Account ID).
- The tags show the User ARN and Region.

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
