# Load Order: Dependencies

Terraform builds a **Graph** to determine creation order.

## 1. Implicit Dependencies (Automatic)

When you reference one resource inside another (`vpc_id = aws_vpc.main.id`), Terraform automatically knows: **Create VPC First**.
You rely on this 99% of the time.

## 2. Explicit Dependencies (`depends_on`)

Sometimes, resources are related logically but not in code.
**Example**:

- An EC2 instance runs a script to download a file from S3.
- The `user_data` script is just a string. Terraform creates the Instance and the S3 Object **in parallel**.
- 💥 **Crash**: Instance starts before file exists.

**Fix**:
Use `depends_on = [aws_s3_object.file]` to force Terraform to wait.

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

- Search for `aws_instance.app_server`.
- Look for `depends_on` or implied order in the output logs (hard to see in Plan, but visible in Apply).

### 3. Apply

```bash
terraform apply --auto-approve
```

Start order will be: Bucket -> Object -> Instance (App Server).

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
