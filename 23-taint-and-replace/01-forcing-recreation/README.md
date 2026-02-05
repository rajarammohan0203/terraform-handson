# Taint & Replace: Forcing Recreation

Sometimes you need to rebuild a resource **even though the code hasn't changed**.

## 🌍 Real-World AWS Scenario

**The Problem:**
You launched an EC2 instance.
A junior admin SSH'd in and accidentally deleted `/etc/hosts` or installed a virus.
Terraform says "No changes" because the `ami` and `instance_type` in the code match the state.
But the server is dead. You need a fresh start.

**The Solution:**
Force Terraform to destroy and recreate it.

## 🚀 Two Ways to Do It

| Method                   | Command                               | Pros                     | Cons                                                       |
| :----------------------- | :------------------------------------ | :----------------------- | :--------------------------------------------------------- |
| **Modern (Recommended)** | `terraform apply -replace="RESOURCE"` | One-step, atomic, safer. | Needs Terraform v0.15+                                     |
| **Legacy**               | `terraform taint RESOURCE`            | Familiar to old users.   | Two steps (Taint, then Apply). Risky if you forget step 2. |

## 🧪 How to Test

### 1. Initialize & Apply

```bash
terraform init
terraform apply --auto-approve
```

**Observe**: Terraform creates `aws_instance.web` (e.g., ID `i-12345`).

### 2. The Modern Fix (-replace)

Run this command to fix the "broken" server immediately:

```bash
terraform apply -replace="aws_instance.web"
```

**Observe**:

- Terraform plans to **replace** the resource (Destroy then Create).
- The ID changes (e.g., `i-67890`).

### 3. The Legacy Way (Taint)

Mark the resource as corrupted:

```bash
terraform taint aws_instance.web
```

**Observe**:

- Message: `Resource instance aws_instance.web has been marked as tainted.`
  Now run apply to fix it:

```bash
terraform apply
```

**Observe**: It is destroyed and recreated again.

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
