# 03-complex-nesting-s3: Advanced Dynamic Logc

This example demonstrates using Dynamic Blocks for **Optional Nested Configuration**.

## The Scenario

S3 Lifecycle rules are complex.

- Some rules have a `transition` action (move to Glacier).
- Some rules only have an `expiration` action (delete).
- Some have both.

## The Solution: Conditional Dynamic Blocks

We use a trick: `for_each = condition ? [1] : []`.

- If the condition is true, we loop over a list with 1 item (creating the block).
- If the condition is false, we loop over an empty list `[]` (creating NO block).

See `main.tf`:

```hcl
dynamic "transition" {
  for_each = rule.value.transition_days != null ? [1] : []
  ...
}
```

## Commands

1.  `terraform init`
2.  `terraform plan`
    - Inspect `logs-rule`: Has both transition and expiration.
    - Inspect `tmp-rule`: Has ONLY expiration.
