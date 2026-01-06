# Count Basics

## What is `count`?

`count` is a special parameter in Terraform that tells it: **"Create this resource N times"**.

Instead of writing the same resource block multiple times, you use `count` to create multiple copies automatically.

### Example:

```hcl
resource "aws_instance" "web_servers" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server-${count.index}"
  }
}
```

This creates **3 EC2 instances** (web servers):

- `web-server-0`
- `web-server-1`
- `web-server-2`

## Real-World Scenario

**Problem**: You need to create 5 identical web servers for load balancing.

**Without count**: You'd write 5 separate `aws_instance` blocks (copy-paste nightmare!).

**With count**: One resource block with `count = 5`.

### Why EC2 is Perfect for Count:

- All servers are **identical** (same AMI, same instance type)
- You want **multiple copies** of the same thing
- The only difference is a number in the name tag

## How `count.index` Works

When you use `count`, Terraform automatically gives you a variable called `count.index`:

- First resource: `count.index = 0`
- Second resource: `count.index = 1`
- Third resource: `count.index = 2`
- ...and so on

You can use `count.index` to make each resource unique (like adding numbers to names).

### Using Custom Names with count.index

**Question**: Can I use different names instead of numbers?

**Answer**: Yes! Use a list and access it with `count.index`:

```hcl
variable "server_names" {
  default = ["dev-amer", "dev-etl", "dev-ameo"]
}

resource "aws_instance" "web_servers" {
  count = 3

  tags = {
    Name = var.server_names[count.index]
  }
}
```

**Result**:

- Server 0: `dev-amer`
- Server 1: `dev-etl`
- Server 2: `dev-ameo`

**Important**: The list length must match the count! If `count = 3` but your list has only 2 items, you'll get an error.

## ⚠️ Limitations

| Issue              | Problem                                                                               | Solution                            |
| :----------------- | :------------------------------------------------------------------------------------ | :---------------------------------- |
| **Changing count** | If you change `count = 3` to `count = 2`, Terraform **destroys** the 3rd resource     | Use `for_each` for stable resources |
| **Order matters**  | Resources are numbered 0, 1, 2... If you delete #1, #2 becomes #1 (forces recreation) | Use `for_each` with sets/maps       |

## When to Use Count

✅ **Good for**:

- Creating multiple identical resources (web servers, worker nodes)
- Temporary resources
- When you know the exact number upfront

❌ **Not good for**:

- Resources you'll add/remove frequently
- Resources that need stable identities (use `for_each` instead)

## 🧪 How to Test (Step-by-Step)

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**: You'll see 3 EC2 instances being created with custom names (dev-amer, dev-etl, dev-ameo).

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Verify in LocalStack

```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-instances
```

**You should see**: 3 instances with custom tags "dev-amer", "dev-etl", "dev-ameo".

### 5. Check Outputs

```bash
terraform output
```

**You'll see**:

- `all_server_ids` = ["i-xxxxx", "i-yyyyy", "i-zzzzz"]
- `all_server_names` = ["dev-amer", "dev-etl", "dev-ameo"]
- `first_server_id` = "i-xxxxx"
- `server_count_created` = 3

### 6. Experiment: Change Count

Edit `variables.tf` and change `default = 3` to `default = 5`:

```bash
terraform plan
```

**Observe**: Terraform will create 2 MORE servers (web-server-3, web-server-4).

### 7. Destroy

```bash
terraform destroy --auto-approve
```

## 📝 Practice Exercise

### Goal

Create 3 S3 buckets using `count` with custom names.

### Step-by-Step Instructions

1. **Open `practice-var.tf`** and uncomment all the code (remove the `#` symbols)

2. **Validate your code**:

   ```bash
   terraform validate
   ```

   ✅ Should say "Success! The configuration is valid."

3. **Plan to see what will be created**:

   ```bash
   terraform plan
   ```

   📋 You should see 3 S3 buckets being created:

   - `logs-bucket`
   - `data-bucket`
   - `backup-bucket`

4. **Apply the changes**:

   ```bash
   terraform apply --auto-approve
   ```

5. **Verify in LocalStack**:

   ```bash
   aws --endpoint-url=http://localhost:4566 s3 ls
   ```

   ✅ You should see your 3 buckets listed!

6. **Check the output**:

   ```bash
   terraform output practice_bucket_names
   ```

   📤 Should show: `["logs-bucket", "data-bucket", "backup-bucket"]`

7. **Clean up**:
   ```bash
   terraform destroy --auto-approve
   ```

### 🎯 Challenge

Try changing the bucket names to your own custom names and re-run the commands!
