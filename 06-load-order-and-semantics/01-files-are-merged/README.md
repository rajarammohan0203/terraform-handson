# Load Order: Files are Merged

A common misconception is that Terraform executes files in order (e.g., `a.tf` then `b.tf`).
**This is FALSE.**

Terraform logic:

1.  **Scan Folder**: Find ALL files ending in `.tf`.
2.  **Flatten**: Merge them into one big in-memory configuration.
3.  **Graph**: Build a dependency graph to decide order (VPC -> Subnet -> Instance).

## 🌍 Real-World AWS Scenario

**The Problem:**
You have a strict organizational policy:

- `network.tf` must own networking.
- `compute.tf` must own servers.
- `storage.tf` must own databases.

**The Solution:**
Terraform handles this natively. You can reference `aws_vpc` (in network.tf) from `aws_instance` (in compute.tf) without any special imports.

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

- Terraform successfully connects `aws_instance.app_server` (in server.tf) to `aws_subnet.main` (in network.tf).
- It creates the VPC first, THEN the Subnet, THEN the Instance. The **Graph** determines `files`, not the filenames.

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
