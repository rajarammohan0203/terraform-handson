# Check Blocks (Continuous Validation)

Validating infrastructure health _without_ stopping deployment.

## 🛑 The Problem with Preconditions

`precondition` stops the apply if it fails.
But what if the checks are "soft" checks?

- "Is the website returning 200 OK?" (Maybe it takes 5 mins to boot).
- "Is the budget unused?" (Important, but don't stop the build).

## ✅ The Solution: `check` blocks

- **Non-Blocking**: If it fails, Terraform print a **WARNING** but finishes successfully.
- **Continuous**: Can be checked anytime.

## 🌍 Real-World AWS Scenario

**Website Health**:
After deploying an EC2 instance, you want to `curl` the homepage.
If it fails, you want to know, but you don't want to destroy the instance.

**Budget Alerts**:
Check if the estimated cost of the environment is > $100. Warn the user, but allow the deploy.

## 🧪 How to Test in LocalStack

1.  **Initialize**:
    ```bash
    terraform init
    ```
2.  **Apply**:
    ```bash
    terraform apply --auto-approve
    ```
    Look for `Check block bucket_health_check: passed` in the output.
3.  **Simulate Failure**:
    Edit `real_world_example.tf` and change the expected region to `"eu-west-1"`.
4.  **Apply Again**:
    **Result**: Apply SUCCESS (Exit code 0), but with a **WARNING** message.

### 2. Test Budget Alert

The hard limit is $100.
**Scenario**: You are at $150.

```bash
terraform apply -var="current_spend=150"
```

**Observation**:

- Terraform creates the resources.
- **POST-APPLY**: It prints:
  > `Warning: Check block budget_alert: failed` > `⚠️  BUDGET EXCEEDED! Current spend ($150) is higher than limit ($100).`

**Critical Concept**:
If you wanted to **BLOCK** the ec2 instance creation completely, you would have used a `precondition` inside the `aws_instance` lifecycle block.
`check` blocks are for "Alerts" and "Monitoring", not for "Enforcement".
