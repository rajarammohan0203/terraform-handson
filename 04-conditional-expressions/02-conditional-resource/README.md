# Conditional Resource Creation

## What is Conditional Resource Creation?

Sometimes you want to create a resource **only in certain conditions**. For example:

- Create a backup bucket **only in production**
- Create a load balancer **only if needed**

## The Pattern: count with Ternary Operator

```hcl
resource "aws_s3_bucket" "backup" {
  count = var.environment == "prod" ? 1 : 0
  #       If prod → create 1, else → create 0 (skip)
}
```

**How it works**:

- `count = 1` → Resource is created
- `count = 0` → Resource is **NOT** created (skipped)

## Real-World Examples

### Example 1: Backup Bucket Only in Production

```hcl
count = var.environment == "prod" ? 1 : 0
```

- Production → Creates the backup bucket
- Dev/Staging → Skips it (saves costs!)

### Example 2: Optional Feature

```hcl
count = var.create_backup ? 1 : 0
```

- If `create_backup` is true → Create it
- If `create_backup` is false → Skip it

## 🧪 How to Test

### Test 1: Development (Default - No Optional Resources)

```bash
terraform init
terraform plan
```

**Observe**:

- Only app_server is created
- NO backup bucket
- NO load balancer

### Test 2: Production (Creates Optional Resources)

```bash
terraform plan -var='environment=prod'
```

**Observe**:

- App server created
- **Backup bucket created** (count = 1)
- **Load balancer created** (count = 1)

### Test 3: Enable Backup

```bash
terraform plan -var='create_backup=true'
```

**Observe**: Monitoring bucket is now created

### Apply and Verify

```bash
terraform apply -var='environment=prod' --auto-approve

# Check S3 buckets
aws --endpoint-url=http://localhost:4566 s3 ls

# Check instances
aws --endpoint-url=http://localhost:4566 ec2 describe-instances

terraform destroy -var='environment=prod' --auto-approve
```

## 📝 Practice

Open `practice-var.tf` and uncomment the code to conditionally create a database!
