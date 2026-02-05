# 02-dynamic-tags-asg: Structure Mismatch

This example shows how to use dynamic blocks to adapt a simple input variable (Map) to a complex resource requirement (Nested Blocks).

## The Problem

`aws_autoscaling_group` traditionally did not accept a simple `tags = { ... }` map.
It required repeated `tag {}` blocks:

```hcl
tag {
  key = "Env"
  value = "Prod"
  propagate_at_launch = true
}
tag {
   ...
}
```

This is painful if you have a standard set of 10 tags you apply everywhere.

## The Solution

We iterate over `var.custom_tags` (a Map) using `dynamic "tag"`.
Inside the content, `tag.key` gives us the map key (e.g., "Environment") and `tag.value` gives the value ("Production").

## Commands

1.  `terraform init`
2.  `terraform plan`
    - Observe how the Map was exploded into individual blocks.
