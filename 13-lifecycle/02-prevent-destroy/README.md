# Lifecycle: Prevent Destroy

Protect critical data from accidental deletion.

## 🛑 The Safety Latch

If you add `prevent_destroy = true`, Terraform will **refuse** to destroy the resource.
This applies to:

1.  `terraform destroy`
2.  `terraform apply` (if a change requires replacement).

## 🌍 Real-World AWS Scenario

**Production Databases (RDS / DynamoDB)**:
You never want a junior developer to accidentally type `terraform destroy` and wipe the production database.
By adding this flag, the command will fail immediately with an error message, saving your data.

## 🧪 How to Test

1.  `terraform apply`.
2.  Try `terraform destroy`.
3.  **Result**: ❌ Error! "Instance cannot be destroyed".
4.  **Cleanup**: You MUST remove the `lifecycle` block from the code before you can destroy it.
