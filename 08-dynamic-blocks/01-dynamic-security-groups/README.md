# 01-dynamic-security-groups: The Classic Loop

This example demonstrates the most common use case for `dynamic` blocks: Generating repeatable nested blocks (ingress rules) from a list.

## The Problem

Without dynamic blocks, if you want to open ports 80, 443, and 22, you have to write:

```hcl
ingress { from_port = 80 ... }
ingress { from_port = 443 ... }
ingress { from_port = 22 ... }
```

This violates the **DRY (Don't Repeat Yourself)** principle.

## The Solution

We use `dynamic "ingress"` with a `for_each` loop.

## Key Syntax

- `dynamic "BLOCK_NAME"`: The name of the nested block (e.g., `ingress`, `tag`, `lifecycle_rule`).
- `for_each`: The collection to loop over.
- `content {}`: The actual body of the generated block.
- `BLOCK_NAME.value`: Accessing the current item value (e.g., `ingress.value`).

## Commands

1.  `terraform init`
2.  `terraform plan`
    - Notice how it creates 4 distinct ingress rules from the single block!
