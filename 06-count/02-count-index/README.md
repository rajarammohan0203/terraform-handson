# Count.index - Advanced Usage

## What is `count.index`?

When you use `count`, Terraform automatically creates a special variable called `count.index` that tells you **which iteration you're on**.

### How it works:

```hcl
count = 3
```

- **First resource**: `count.index = 0`
- **Second resource**: `count.index = 1`
- **Third resource**: `count.index = 2`

## Real-World Scenarios

### 1. Numbered Names

**Problem**: Create 3 S3 buckets with sequential names.

```hcl
resource "aws_s3_bucket" "logs" {
  count  = 3
  bucket = "app-logs-${count.index}"
}
```

**Result**: `app-logs-0`, `app-logs-1`, `app-logs-2`

### 2. Accessing List Items

**Problem**: Create 3 subnets with different CIDR blocks from a list.

```hcl
variable "subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

resource "aws_subnet" "subnets" {
  count      = 3
  cidr_block = var.subnet_cidrs[count.index]
}
```

**Result**:

- Subnet 0: `10.0.1.0/24`
- Subnet 1: `10.0.2.0/24`
- Subnet 2: `10.0.3.0/24`

### 3. Math with count.index

**Problem**: Start numbering from 1 instead of 0.

```hcl
resource "aws_iam_user" "team" {
  count = 5
  name  = "team-member-${count.index + 1}"
}
```

**Result**: `team-member-1`, `team-member-2`, ..., `team-member-5`

## When to Use count.index

✅ **Good for**:

- Creating numbered resources (server-0, server-1, server-2)
- Accessing list items by position
- Sequential CIDR blocks for subnets
- Port ranges (8080, 8081, 8082...)

## 🧪 How to Test (Step-by-Step)

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- 3 S3 buckets with names using `count.index`
- 3 Subnets with CIDRs from the list (accessed via `count.index`)
- 5 IAM users with `count.index + 1`

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Verify in LocalStack

**Check S3 Buckets**:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

**You should see**: `app-logs-0`, `app-logs-1`, `app-logs-2`

**Check Subnets**:

```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-subnets
```

**Look for**: 3 subnets with different CIDR blocks

**Check IAM Users**:

```bash
aws --endpoint-url=http://localhost:4566 iam list-users
```

**You should see**: `team-member-1` through `team-member-5`

### 5. Check Outputs

```bash
terraform output
```

### 6. Destroy

```bash
terraform destroy --auto-approve
```

## 📝 Practice

Open `practice-var.tf` and try creating resources for different environments (dev, staging, prod) using `count.index` to access environment names from a list!
