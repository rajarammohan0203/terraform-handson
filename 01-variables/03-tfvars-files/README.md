# Practical: Managing Environments with `.tfvars` 🗂️

In real projects, you never hardcode values. You use `.tfvars` files to define separate configurations for **Development**, **Staging**, and **Production**.

## 🔑 Key Concepts
*   **One Codebase, Multiple Outputs**: The `.tf` code stays the same. The `.tfvars` file changes.
*   **Instance Sizing**: Dev gets cheap `t2.micro` servers. Prod gets powerful `m5.large` servers.
*   **Scaling**: Dev gets 1 server. Prod gets 3 servers (High Availability).

## 🛠️ The Scenario
We have one `main.tf` logic, but we want two completely different results:

| Feature | Development (`dev.tfvars`) | Production (`prod.tfvars`) |
| :--- | :--- | :--- |
| **VPC CIDR** | `10.0.0.0/16` | `192.168.0.0/16` |
| **Instance Count** | 1 | 3 |
| **Instance Type** | `t2.micro` (Cheap) | `m5.large` (Powerful) |
| **Logging Tag** | `false` | `true` |

---

## 🚀 Step-by-Step Instructions

### Step 1: Initialize
Setup the directory.
```bash
terraform init
```

### Step 2: Run the "Development" Plan
We tell Terraform: *"Use the variables defined in `dev.tfvars`"*.
```bash
terraform plan -var-file="dev.tfvars"
```
**Observation**:
*   Look for `t2.micro`.
*   Look for `count = 1`.
*   Look for tags including `Environment = "development"`.

### Step 3: Apply "Development"
Create the Dev environment.
```bash
terraform apply -var-file="dev.tfvars" -auto-approve
```
*Verify it exists:*
```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-instances --filters "Name=tag:Environment,Values=development" --region us-east-1
```

### Step 4: Switch to "Production" (The Magic 🪄)
Now, imagine you are deploying to Prod. Run the same command but with the **prod** file.
```bash
terraform apply -var-file="prod.tfvars" -auto-approve
```
**Observation (Important)**:
*   Terraform sees that the `Environment` tag changed from `development` to `production`.
*   It sees `count` went from 1 to 3.
*   It sees `instance_type` went from `t2.micro` to `m5.large`.
*   **Result**: It will likely destroy the old dev instances and force-create new prod instances (because some changes like AMI or specific recreations might be triggered, or just update in place depending on the cloud provider logic. In LocalStack/Terraform logic, changing `count` and properties often triggers recreation).

### Step 5: Verify Production
```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-instances --filters "Name=tag:Environment,Values=production" --region us-east-1
```
*You should see 3 instances listed.*

## 🚀 Advanced: Running Side-by-Side (Workspaces)

To solve the "replacement" issue and run Dev and Prod at the same time, we use **Workspaces**. This tells Terraform to create separate state files for each environment.

### 1. Create & Select 'dev' Workspace
```bash
terraform workspace new dev
# Selected default workspace "dev"!
```

### 2. Apply Dev Configuration
```bash
terraform apply -var-file="dev.tfvars" -auto-approve
```
*   This creates a state file inside `terraform.tfstate.d/dev/`.
*   You now have a running Dev environment.

### 3. Create & Select 'prod' Workspace
Now, let's switch contexts completely.
```bash
terraform workspace new prod
# Created and switched to workspace "prod"!
```
*   Terraform now sees an **empty** state. It knows nothing about the Dev resources (they are safe!).

### 4. Apply Prod Configuration
```bash
terraform apply -var-file="prod.tfvars" -auto-approve
```
*   This creates **NEW** resources for Prod.
*   **Result**: You now have both Dev (Micro) and Prod (Large) running side-by-side!

### 5. Switching Back and Forth
```bash
terraform workspace select dev
# Now 'plan' will show you the Dev status

terraform workspace select prod
# Now 'plan' will show you the Prod status
```

### 6. Cleanup
You must destroy both workspaces separately.
```bash
terraform workspace select dev
terraform destroy -var-file="dev.tfvars" -auto-approve

terraform workspace select prod
terraform destroy -var-file="prod.tfvars" -auto-approve
```

---

## 🧹 Cleanup (Standard)
If you didn't use workspaces:
```bash
terraform destroy -var-file="prod.tfvars" -auto-approve
```
