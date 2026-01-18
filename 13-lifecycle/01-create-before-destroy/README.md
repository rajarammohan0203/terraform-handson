# Lifecycle: Create Before Destroy

Avoid accidental downtime during replacements.

## ☠️ The Default Behavior (Downtime)

1.  **Stop/Destroy** the old server (`i-old`).
2.  (Users see 503 Errors).
3.  **Start/Create** the new server (`i-new`).

## ✅ The Fix: `create_before_destroy`

1.  **Start/Create** the new server (`i-new`).
2.  (Both run simultaneously for a moment).
3.  **Stop/Destroy** the old server (`i-old`).
4.  (Users never lose service).

## 🌍 Real-World AWS Scenario

**Launch Templates / Launch Configurations**:
You cannot delete a Launch Config that is attached to an Auto Scaling Group.
If you try to update it without `create_before_destroy`, Terraform might try to delete the old one first -> **FAIL** (AWS Error: ResourceInUse).
You MUST use `create_before_destroy = true` so the new one exists before swapping.

## 🧪 How to Test

1.  `terraform apply` (Creates ID: `i-111`, Tag: `v1`)
2.  Change Tag to `v2`.
3.  `terraform apply`
4.  **Watch the order**:
    - It says `aws_instance.web: Creating...`
    - THEN `aws_instance.web: Destroying...`
