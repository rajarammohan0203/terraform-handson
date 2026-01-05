# Practical: Variable Precedence 🥇

Who wins when you set the same variable in 5 different places? Terraform has a strict **Order of Precedence**. The last one loaded "wins".

## 🏆 The Hierarchy (Winner at the Top)

1.  **CLI Flags**: `-var` or `-var-file` (Highest Priority)
2.  **Auto Maps**: `*.auto.tfvars` or `*.auto.tfvars.json`
3.  **The File**: `terraform.tfvars`
4.  **Environment Variables**: `TF_VAR_variable_name`
5.  **Defaults**: `variable { default = ... }` (Lowest Priority)

---

## 🚀 Prove it Yourself (Step-by-Step)

### 1. Initialize
```bash
terraform init
```

### 2. The Baseline (Defaults)
Delete `terraform.tfvars` temporarily to see the default functionality.
```bash
rm terraform.tfvars
terraform apply -auto-approve
```
**Result**: `Blue (From Default)`

### 3. Level Up: Environment Variables
Let's set an environment variable.
```bash
export TF_VAR_favorite_color="Orange (From Env Var)"
terraform apply -auto-approve
```
**Result**: `Orange (From Env Var)`
*(Env Vars priority > Default)*

### 4. Level Up: `terraform.tfvars` file
Create the file again.
```bash
echo 'favorite_color = "Green (From terraform.tfvars)"' > terraform.tfvars
terraform apply -auto-approve
```
**Result**: `Green (From terraform.tfvars)`
*(tfvars priority > Env Vars)*

### 5. Level Up: Auto-Load Files
Create a file ending in `.auto.tfvars`.
```bash
echo 'favorite_color = "Purple (From auto.tfvars)"' > special.auto.tfvars
terraform apply -auto-approve
```
**Result**: `Purple (From auto.tfvars)`
*(auto.tfvars priority > tfvars)*

### 6. The Ultimate Winner: CLI Flag
Override everything with the command line.
```bash
terraform apply -var="favorite_color=Red (From CLI)" -auto-approve
```
**Result**: `Red (From CLI)`
*(CLI priority > Everything)*

## 🧹 Cleanup
```bash
# Unset the env var
unset TF_VAR_favorite_color

# Remove created files
rm terraform.tfvars special.auto.tfvars

# Destroy resources
terraform destroy -auto-approve
```
