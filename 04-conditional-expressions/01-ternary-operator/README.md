# Ternary Operator (? :)

## What is the Ternary Operator?

The ternary operator is Terraform's way of writing **if-else** logic in one line.

### Syntax:

```hcl
condition ? true_value : false_value
```

**Read as**: "If condition is true, use true_value, otherwise use false_value"

## Real-World Examples

### Example 1: Different Instance Types

```hcl
instance_type = var.environment == "prod" ? "t2.large" : "t2.micro"
```

- Production → Powerful server (t2.large)
- Development → Cheap server (t2.micro)

### Example 2: Enable/Disable Features

```hcl
monitoring = var.enable_monitoring ? true : false
```

- If `enable_monitoring` is true → Enable monitoring
- If `enable_monitoring` is false → Disable monitoring

## 🧪 How to Test

### Test 1: Development (Default)

```bash
terraform init
terraform plan
```

**Observe**: Instance type is `t2.micro`, monitoring is `false`

### Test 2: Production

```bash
terraform plan -var='environment=prod'
```

**Observe**: Instance type changes to `t2.large`

### Test 3: Enable Monitoring

```bash
terraform plan -var='enable_monitoring=true'
```

**Observe**: Monitoring is now `true`

### Apply and Verify

```bash
terraform apply --auto-approve
aws --endpoint-url=http://localhost:4566 ec2 describe-instances
terraform destroy --auto-approve
```

## 📝 Practice

Open `practice-var.tf` and uncomment the code to practice!
