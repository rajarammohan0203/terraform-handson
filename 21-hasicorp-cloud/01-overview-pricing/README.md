# 01-overview-pricing: HCP Terraform (Formerly Terraform Cloud)

## What is it?

**HCP Terraform** (HashiCorp Cloud Platform) is a SaaS platform that manages your Terraform runs.

### Key Benefits

1.  **Remote State Management**: No more managing S3 buckets and DynamoDB tables manually. It's built-in.
2.  **Remote Execution**: `terraform apply` runs on HashiCorp's servers (Virtual Machines), not your laptop. This ensures a consistent environment (no "It works on my machine" issues).
3.  **Private Registry**: Share modules privately within your company.
4.  **VCS Integration**: Connects to GitHub/GitLab. When you merge a Pull Request, HCP automagically runs `terraform apply`.

## Pricing Tiers (Simplified)

### 1. Free Tier (The Generous One)

- **Cost**: $0.
- **Users**: Up to 5 users.
- **Features**: Remote Runs, State Management, Private Registry, VCS Integration.
- _Ideal for:_ Individuals and small teams.

### 2. Standard / Plus (The Enterprise One)

- **Cost**: Paid per user/hour.
- **Features**:
  - **SSO** (Single Sign-On like Okta).
  - **Sentinel** (Policy as Code).
  - **Run Tasks** (Integrations with 3rd party tools).
  - **Self-Hosted Agents** (Run Terraform inside your own private network).
  - **Audit Logs**.

## Concepts

- **Organization**: The top-level container (e.g., "my-company").
- **Workspace**: Corresponds to a single State File (e.g., "shared-vpc-prod").
