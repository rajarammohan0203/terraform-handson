# 03-ephemeral-values: The "Ghost" Data

## The Problem: State File Leaks

In standard Terraform, **EVERYTHING** you use in a resource argument is saved to `terraform.tfstate`.

- Passwords? Saved.
- API Keys? Saved.
- Private Keys? Saved.

Even `sensitive = true` only hides it from the _screen_. It is strictly written to the disk in the state file.

## The Solution: Ephemeral Values (`ephemeral = true`)

Terraform v1.10+ introduced **Ephemeral Values**.
These are values that Terraform allows you to use during the `apply` phase, but it **REFUSES** to write them to the state file.

### Real-World Use Case: The "Deployment Token"

Imagine you need to run a script that connects to a database to run migrations.

1.  You need the DB Password.
2.  You pass it to `null_resource` or `terraform_data`.
3.  **Old Way**: The password is saved in `terraform_data` state. Risk!
4.  **Ephemeral Way**: You mark the variable as `ephemeral = true`. Terraform uses it for the script, then "forgets" it immediately. It is never written to disk.

### Scenario Code

```hcl
variable "token" {
  ephemeral = true # <--- The Shield
}

resource "terraform_data" "db_migration" {
  provisioner "local-exec" {
    command = "./migrate.sh --token=${var.token}"
  }
}
```

### When to use `ephemeral` resources?

Use `ephemeral "type" "name" {}` blocks when you need to **READ** data (like an MFA token or a Dynamic Secret from Vault) that is only valid for 5 minutes.
Since it expires anyway, saving it to State is useless—and dangerous.
