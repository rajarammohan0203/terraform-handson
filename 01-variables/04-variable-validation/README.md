# Practical: Variable Validation 🛡️

You can stop users from entering bad data (like "ubuntu-linux" instead of "ami-123") using the `validation` block. This functionality is built-in to Terraform logic!

## 🔑 Key Concepts
*   **Fail Fast**: Catch errors *before* calling the AWS/LocalStack API.
*   **The `validation` Block**: Inside a variable definition.
*   **`condition`**: Must be `true` for the value to be accepted.
*   **`error_message`**: What to show the user if they fail.

## 🛠️ The Rules We Added
1.  **AMI ID**: Must start with `"ami-"`.
2.  **Environment**: Must be exactly `"dev"`, `"prod"`, or `"staging"`.
3.  **Instance Type**: Must be `"t2.micro"` or `"t2.small"`.

## 🚀 Steps to Verify

### 1. Initialize
```bash
terraform init
```

### 2. The Success Path
Run logic that obeys the rules (`dev` and `t2.micro`).
```bash
terraform apply -var="environment=dev" -auto-approve
```
*Result: Success!*

### 3. The Failure Path (Try to break it!)
Try to pass a bad environment name like "testing" (which is not in our allowed list).
```bash
terraform apply -var="environment=testing"
```
**Observation**: Terraform will stop you immediately!
> *Error: Environment must be one of: dev, prod, staging.*

### 4. Challenge
Try to provide a bad AMI ID and see the error.
```bash
terraform plan -var="environment=dev" -var="ami_id=bad-ami-123"
```

## 🧹 Cleanup
```bash
terraform destroy -var="environment=dev" -auto-approve
```
