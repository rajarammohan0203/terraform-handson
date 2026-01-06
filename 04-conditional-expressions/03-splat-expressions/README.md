# Splat Expressions ([*])

## What are Splat Expressions?

When you create multiple resources with `count`, you often want to get a specific attribute from **ALL of them**. That's where splat expressions come in!

### Syntax:

```hcl
resource_name[*].attribute
```

**Translation**: "Get this attribute from ALL instances of this resource"

## The Problem Splat Solves

### Without Splat (Manual):

```hcl
output "instance_ids" {
  value = [
    aws_instance.web_servers[0].id,
    aws_instance.web_servers[1].id,
    aws_instance.web_servers[2].id,
  ]
}
```

❌ Tedious! What if you have 100 instances?

### With Splat (Automatic):

```hcl
output "instance_ids" {
  value = aws_instance.web_servers[*].id
}
```

✅ Gets ALL instance IDs automatically!

## Real-World Examples

### Example 1: Get All Instance IDs

```hcl
aws_instance.web_servers[*].id
```

**Result**: `["i-123", "i-456", "i-789"]`

### Example 2: Get All Bucket Names

```hcl
aws_s3_bucket.data_buckets[*].bucket
```

**Result**: `["data-bucket-0", "data-bucket-1"]`

### Example 3: Count Total Resources

```hcl
length(aws_instance.web_servers[*].id)
```

**Result**: `3` (total number of instances)

## Common Use Cases

| Use Case         | Code                         | Result            |
| :--------------- | :--------------------------- | :---------------- |
| Get all IDs      | `resource[*].id`             | List of all IDs   |
| Get all names    | `resource[*].tags.Name`      | List of all names |
| Count resources  | `length(resource[*].id)`     | Total count       |
| Join with commas | `join(", ", resource[*].id)` | "id1, id2, id3"   |

## 🧪 How to Test

### Test 1: Default (3 instances, 2 buckets)

```bash
terraform init
terraform plan
```

**Observe outputs**:

- `all_instance_ids` = List of 3 IDs
- `all_bucket_names` = List of 2 bucket names
- `total_instances` = 3

### Test 2: Apply and Check Outputs

```bash
terraform apply --auto-approve
terraform output
```

**You'll see**:

- `all_instance_ids` = ["i-xxx", "i-yyy", "i-zzz"]
- `all_instance_names` = ["web-server-0", "web-server-1", "web-server-2"]
- `all_bucket_names` = ["data-bucket-0", "data-bucket-1"]
- `instance_summary` = "Created 3 instances with IDs: i-xxx, i-yyy, i-zzz"

### Test 3: Change Count

```bash
terraform plan -var='instance_count=5'
```

**Observe**: Splat expression automatically handles 5 instances!

### Verify in LocalStack

```bash
# Check instances
aws --endpoint-url=http://localhost:4566 ec2 describe-instances

# Check buckets
aws --endpoint-url=http://localhost:4566 s3 ls

terraform destroy --auto-approve
```

## 📝 Practice

Open `practice-var.tf` and uncomment the code to practice with IAM users!

## 🎯 Key Takeaway

**Splat `[*]` = "Get this from ALL of them"**
