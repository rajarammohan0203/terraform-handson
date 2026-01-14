# Locals: Logic & Transformations

In advanced Terraform, **Locals** act as the **Calculation Layer**.
Instead of making your resource blocks messy with `if/else` logic or string formatting, define them in a `local` first.

## 🌍 Real-World AWS Scenario

**The Problem:**
Users pass messy inputs (mixed case).
Business logic is complex: "If Prod AND HA enabled, launch 3 servers. If Dev, launch 1."

**The Solution:**
Do the math in `locals`, then just pass the result to the resource.

```hcl
locals {
  # 1. Clean the input
  env_clean = lower(var.env)

  # 2. Do the math
  instance_count = local.env_clean == "prod" ? 3 : 1
}

resource "aws_instance" "web" {
  # 3. Use the clean result
  count = local.instance_count
}
```

## 🕹️ Test with Terraform Console

1. Run the console:

   ```bash
   terraform console
   ```

2. Inspect the logic:

   ```hcl
   > local.env_clean
   "prod"

   > local.instance_count
   3

   > local.cost_code
   "finance-prod-001"
   ```

## 🧪 Run the Example

### 1. Initialize

```bash
terraform init
```

### 2. Plan (Default: Prod)

```bash
terraform plan
```

**Observe**:

- Input is `PrOd` (messy), but tags show `app-prod-0` (clean).
- Instance Count is **3** (because Prod + HA = 3).
- Cost Center is `finance-prod-001`.

### 3. Change Logic

Switch to Dev environment.

```bash
terraform plan -var='env_name=DEV'
```

**Observe**:

- Instance Count drops to **1**.
- Cost Center updates to `finance-dev-001`.

### 4. Apply

```bash
terraform apply --auto-approve
```

### 5. Clean Up

```bash
terraform destroy --auto-approve
```
