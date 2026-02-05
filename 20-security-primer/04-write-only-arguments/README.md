# 04-write-only-arguments: Input Security

This example explains the concept of **Write-Only Arguments**.

## The Concept

Some resources have arguments that you can **SET**, but the API will never **RETURN**.
Example: `aws_db_instance` password.

1.  You write: `password = "secret123"`
2.  Terraform sends to AWS: `CREATE DB ... password=secret123`
3.  AWS responds: `DB Created. ID=db-1. Status=Creating.` (It does NOT send the password back).

## Why?

This is a security feature of the Cloud Provider's API, not just Terraform. It prevents the password from being exposed if someone queries the API (e.g., `aws rds describe-db-instances`).

## Terraform's Behavior

If you try to `output` the password from the resource attribute later (e.g., `value = aws_db_instance.mydb.password`), Terraform will error or return nothing, because it simply doesn't know it anymore!
The only place it "remembers" it is in the State File (which brings us back to lesson #03).
