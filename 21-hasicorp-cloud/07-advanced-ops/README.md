# 07-advanced-ops: Triggers & Health

## Run Triggers

In a microservices architecture, you split state files.

- **Networking** (VPC)
- **App 1** (EC2)
- **App 2** (Lambda)

If Networking changes, App 1 and App 2 might need to update (to pick up new Subnet IDs).
**Run Triggers** automate this. You chain them together so a commit to Networking cascades a Plan to the Apps.

## Health Assessments (Drift Detection)

Normally, Terraform only knows about changes when you run `plan`.
**Health Assessments** (Business Tier feature) run a `plan` periodically (e.g., every 24 hours) automatically.

- **Drift**: If someone manually deleted an S3 bucket in the AWS Console, the Health Assessment detects it and alerts you "Drift Detected!".
