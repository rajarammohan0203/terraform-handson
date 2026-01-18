# 9. Dependencies: Implicit vs Explicit

Understanding how Terraform decides **Order of Execution** is vital to prevent race conditions.

| Type         | How it works                                                            | When to use                                                                     |
| :----------- | :---------------------------------------------------------------------- | :------------------------------------------------------------------------------ |
| **Implicit** | Automatic. Terraform sees you used `resource.A.id` inside `resource.B`. | **95% of the time.** Standard references (VPC ID, SG ID, Subnet ID).            |
| **Explicit** | Manual. You add `depends_on = [resource.A]`.                            | **Hidden dependencies.** (e.g., Script needs S3 file, Lambda needs IAM Policy). |

## 🌍 Real-World AWS Scenario

**The Crash:**
You launch an EC2 instance that runs a script: `aws s3 cp s3://my-bucket/config.json`.
Terraform launches the Instance and uploads the File **at the same time** (Parallelism).
The Instance starts 2 seconds faster than the upload.
**Result**: Script fails. File not found.

**The Fix:**
Tell the Instance: "Do not start until the Object is uploaded."

```hcl
resource "aws_instance" "app" {
  ...
  depends_on = [aws_s3_object.config_file]
}
```

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
Terraform calculates the graph. It knows it MUST create the S3 Object before the App Server.

### 3. Apply

```bash
terraform apply --auto-approve
```

**Verify**:
If you watch the logs, `aws_s3_object.config_file` will finish Creating BEFORE `aws_instance.app_server` starts Creating.

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
