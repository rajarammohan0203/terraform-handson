# Locals: Code Simplification

The primary goal of Locals here is **Readability**.
When your resource blocks are full of complex string interpolations or long scripts, they become hard to read. Locals let you move that "noise" to the top of the file.

## 🌍 Real-World AWS Scenario

**The Problem:**
You have an EC2 instance with a generic User Data script and a complex naming convention involving 3-4 variables.
Your `aws_instance` block looks messy and is 50 lines long.

**The Solution:**
Extract the script and the name into `locals`.

**Before (Messy):**

```hcl
resource "aws_instance" "web" {
  user_data = <<-EOF
    #!/bin/bash
    echo "This script takes up 20 lines..."
    ...
  EOF
  tags = {
    Name = "${var.app}-${var.env}-${var.region}-${var.tier}" # Hard to read
  }
}
```

**After (Clean):**

```hcl
locals {
  startup_script = <<-EOF ... EOF
  full_name      = "${var.app}-${var.env}-${var.region}-${var.tier}"
}

resource "aws_instance" "web" {
  user_data = local.startup_script
  tags = { Name = local.full_name }
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
The `aws_instance` will be created with:

- Name: `payment-service-prod-us-east-1-frontend`
- User Data: The script defined in locals.

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
