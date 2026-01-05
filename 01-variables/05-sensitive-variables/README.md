# Practical: Sensitive Variables & SSM 🤫

Handling passwords requires care. We use `sensitive = true` to hide them in the CLI, and **AWS Systems Manager (SSM) Parameter Store** to store them securely in the cloud.

## 🔑 Key Concepts
*   **`sensitive = true`**: Added to the `variable` block. Terraform replaces the value with `(sensitive value)` in the console output.
*   **AWS SSM Parameter Store**: A secure place to store secrets (passwords, API keys).
*   **`SecureString`**: The parameter type ensuring the value is encrypted.

## ⚠️ CRITICAL WARNING: The State File
Marking a variable as sensitive **ONLY** hides it from the CLI (Terminal).
It is **STILL VISIBLE** in plain text inside the `terraform.tfstate` file.
> **Rule**: Always treat your state file as highly confidential.

## 🚀 Steps to Run

### 1. Initialize
```bash
terraform init
```

### 2. Plan (Observe the Masking)
We will pass the password via a flag.
**Note**: Use **single quotes** `'...'` if your password has special characters like `!`.
```bash
terraform plan -var='db_password=SuperSecretPassword123!'
```
**Observation**: Look at the plan output for the `value` field.
*   Instead of `SuperSecretPassword123!`, you will see `(sensitive value)`.

### 3. Apply
```bash
terraform apply -var='db_password=SuperSecretPassword123!' -auto-approve
```

### 4. Verify in LocalStack (SSM)
We stored the password in the **Systems Manager Parameter Store**. Let's verify it actually exists and is encrypted.

```bash
# Get the decrypted value (Requires --with-decryption)
aws --endpoint-url=http://localhost:4566 ssm get-parameter --name "/production/database/password" --with-decryption
```
*You should see your password in the output JSON.*

### 5. Check Terraform Outputs
Try to view the output we defined.
```bash
terraform output password_value
```
*   **Result**: Terraform will say `(sensitive value)`.

## 🧹 Cleanup
```bash
terraform destroy -var='db_password=SuperSecretPassword123!' -auto-approve
```

## 🐛 Troubleshooting: `dquote>`
If you see `dquote>` getting stuck in your terminal, it's because `!` is a special character in Bash/Zsh.
*   **Wrong**: `"...123!"` (Shell tries to expand history).
*   **Correct**: `'...123!'` (Single quotes treat it as raw text).
