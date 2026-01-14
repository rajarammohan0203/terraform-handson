# Locals: Avoiding Repetition (DRY)

**Locals** (Local Values) are like "temporary constants" inside your Terraform code.
They allow you to assign a name to an expression or value, so you can reuse it multiple times.

| Concept               | Description                                                       |
| :-------------------- | :---------------------------------------------------------------- |
| **Variables (`var`)** | Inputs coming from **OUTSIDE** (users, tfvars files).             |
| **Locals (`local`)**  | Values calculated **INSIDE** Terraform (combinations, constants). |

## 🌍 Real-World AWS Scenario

**The Problem:**
You are creating 10 resources (buckets, servers, databases).
Every single one needs:

1. A consistent naming prefix (e.g., `project-env-...`).
2. A standard set of tags (`Project`, `Environment`, `Owner`).

**The Bad Way (Repetition):**

```hcl
resource "aws_s3_bucket" "a" {
  bucket = "${var.project}-${var.env}-bucket-a"
  tags = { Project = var.project, Env = var.env ... } # Copied...
}
resource "aws_s3_bucket" "b" {
  bucket = "${var.project}-${var.env}-bucket-b"
  tags = { Project = var.project, Env = var.env ... } # Copied again...
}
```

**The Good Way (Locals):**

```hcl
locals {
  prefix = "${var.project}-${var.env}"
  common_tags = { ... }
}

resource "aws_s3_bucket" "a" {
  bucket = "${local.prefix}-bucket-a"
  tags   = local.common_tags
}
```

## 🕹️ Test with Terraform Console

1. Run the console:

   ```bash
   terraform console
   ```

2. Try to define a local (Note: You **cannot** define locals inside the console, you can only READ them if they are in your code).

   To test, make sure you ran `terraform init` first!

   ```hcl
   > local.name_prefix
   "marketing-campaign-dev"

   > local.common_tags
   {
     "Environment" = "dev"
     "ManagedBy" = "Terraform"
     "Owner" = "MarketingTeam"
     "Project" = "marketing-campaign"
   }
   ```

## 🧪 Run the Example

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- Both S3 buckets start with `marketing-campaign-dev-`.
- Both buckets and the EC2 instance have the exact same Tags.

### 3. Change Once, Update Everywhere

1. Open `variables.tf` and change `environment` from `"dev"` to `"prod"`.
2. Run `terraform plan` again.
   **Observe**: Every single resource name and tag updates automatically!

### 4. Apply

```bash
terraform apply --auto-approve
```

### 5. Clean Up

```bash
terraform destroy --auto-approve
```
