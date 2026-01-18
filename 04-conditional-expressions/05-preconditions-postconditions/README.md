# Preconditions & Postconditions (Defensive Coding)

Validate Resources and Data Sources during execution.

| Type | When it runs | Purpose |
|:---|:---|:---|
| **`precondition`** | **BEFORE** API call | usage Check "Can I safely start?" (e.g., Is the AMI valid? Is the specific subnet available?). |
| **`postcondition`** | **AFTER** API call | Quality Check "Did it work correctly?" (e.g., Is the health check URL valid?). |

## 🌍 Real-World AWS Scenario

**Compliance Enforcing**:
*   **Precondition**: Prevent anyone from launching `t2.nano` in Production (fail fast).
*   **Postcondition**: After creating a Security Group, ensure it doesn't accidentally have `0.0.0.0/0` (Open to World) on Port 22. If it does, Fail the apply!

## 🧪 How to Test

### 1. Test Postcondition Failure
The default `volume_size` is 5GB. The code requires >= 10GB.
```bash
terraform init
terraform apply
```
**Result**: ❌ Error: "Volume size must be at least 10 GB"

### 2. Test Success
```bash
terraform apply -var="volume_size=20"
```
**Result**: Match!

### 3. Test Precondition Failure
Try to use an `m5` instance family.
```bash
terraform plan -var="instance_type=m5.large"
```
**Result**: ❌ Error: "Only supports T2 instance types".
