# Lifecycle: Ignore Changes

Manage Drift and External Updates without fighting Terraform.

## 🛑 The Problem (Fighting drift)

Terraform wants the state to match the code EXACTLY.
If **AWS AutoScaling** increases your instance count to 5, but your code says 1...
Terraform will scale it back down to 1 on the next apply. 🔥

## ✅ The Fix: `ignore_changes`

Tell Terraform: "I don't care about this specific attribute. Let it be."

## 🌍 Real-World AWS Scenario

1.  **Auto Scaling Groups**:
    `ignore_changes = [desired_capacity]` so Terraform doesn't fight usage spikes.
2.  **External Tagging (Billing/Compliance Bots)**:
    Many companies have "Bots" that scan resources and tag them with `CostCenter` or `CreatedBy` automatically after creation.
    **Without `ignore_changes`**: Terraform sees these new tags as "Drift" and will **DELETE** them on the next apply.
    **With `ignore_changes`**: Terraform allows the bot to do its job.

    ```hcl
    resource "aws_instance" "example" {
      tags = { Code = "MyTag" }

      lifecycle {
        ignore_changes = [tags]
      }
    }
    ```

## 🧪 How to Test

1.  `terraform apply`.
2.  **Simulate Drift**: Manually add a tag or change a property that is ignored.
3.  `terraform plan`.
4.  **Result**: "No changes. Your infrastructure matches the configuration."
