# Input Variable Validation

Stop bad inputs **before** they run.

## 🛑 The Problem
Users (or CI/CD pipelines) make mistakes.
*   Typo: `env = "prdo"` instead of `prod`.
*   Bad Format: `ami = "vmi-123"` instead of `ami-123`.

If you don't validate, Terraform might partially run or create a resource with a bad name like `server-prdo`.

## ✅ The Solution: `validation {}` block
Inside `variables.tf`, you can enforce rules using `contains()` or `regex()`.

## 🌍 Real-World AWS Scenario
**Standardizing Environment Names**:
You only want to pay for `dev` and `prod`. You don't want someone creating `sandbox` resources that get orphaned. Variable validation enforces this policy at the code level.

## 🧪 How to Test

### 1. Test Valid Input
```bash
terraform init
terraform plan -var="environment=prod"
```
**Result**: Success.

### 2. Test Invalid Input
```bash
terraform plan -var="environment=uat"
```
**Result**: ❌ Error! "Environment must be one of: dev, staging, prod."
 Terraform REFUSES to even start.
