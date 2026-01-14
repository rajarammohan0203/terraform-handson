# Locals vs Variables

Understanding when to use which is critical for writing clean Terraform.

| Feature          | Variables (`var`)                            | Locals (`local`)                                     |
| :--------------- | :------------------------------------------- | :--------------------------------------------------- |
| **Origin**       | **External** (User input, tfvars, CLI)       | **Internal** (Calculated inside code)                |
| **Overridable?** | ✅ Yes (`-var` or `.tfvars`)                 | ❌ No (Hardcoded logic)                              |
| **Dependencies** | ❌ Independent (Cannot reference other vars) | ✅ Dependent (Can use vars, resources, other locals) |
| **Use Case**     | Project names, Region, Instance Size         | Naming conventions, Tag merging, Cleaning data       |

## 🌍 Real-World AWS Scenario

**Scenario**: You want a bucket name to be `project-env`.

❌ **Valid Variable? NO**
You **cannot** do this in `variables.tf`:

```hcl
variable "bucket_name" {
  default = "${var.project}-${var.env}" # ERROR: Variables cannot reference other variables!
}
```

✅ **Valid Local? YES**
You **must** use a local for this:

```hcl
locals {
  bucket_name = "${var.project}-${var.env}" # Works perfectly!
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

- `user_input_var`: The raw input "CloudApp".
- `calculated_local`: The transformed output "cloudapp-dev-data-center".

### 3. Override Variable

Try to override the variable (Allowed):

```bash
terraform plan -var="project=SkyNet"
```

**Result**: Logic updates automatically. `calculated_local` becomes "skynet-dev-data-center".

### 4. Try to Override Local (Impossible)

You cannot do `-var="local.bucket_name=foo"`. Locals are internal logic only!

### 5. Clean Up

```bash
terraform destroy --auto-approve
```
