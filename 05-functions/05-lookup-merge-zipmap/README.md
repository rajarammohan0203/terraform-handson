# Map Functions: Lookup, Merge, Zipmap

These are the "Big 3" for managing complex data structures in Terraform.

| Function     | Purpose                                                                 | Example                          |
| :----------- | :---------------------------------------------------------------------- | :------------------------------- |
| **`lookup`** | **Safe Retrieval**. Gets a value from a map, or a default if missing.   | `lookup(map, "key", "default")`  |
| **`merge`**  | **Combine**. Merges multiple maps into one.                             | `merge(map1, map2)`              |
| **`zipmap`** | **Construct**. Combines a List of Keys and a List of Values into a Map. | `zipmap(keys_list, values_list)` |

## 🔥 Production Scenarios (Deep Dive)

Here is how these functions save you in a real job.

### 1. `lookup()`: Multi-Region Deployment Strategy

**The Scenario**: You deploy to 3 regions: `us-east-1`, `us-west-2`, and `eu-central-1`.
You have specific AMIs for each. But sometimes, a developer creates a workspace for a **new region** (e.g., `ap-south-1`) that you haven't set up yet.

**Without `lookup`**: Deployment **FAILS** violently with "Key not found".
**With `lookup`**: You deploy a "Default/Fallback" AMI so the pipeline doesn't crash, allowing the dev to at least test networking.

```hcl
variable "region_amis" {
  default = {
    us-east-1 = "ami-123"
    us-west-2 = "ami-456"
  }
}

# In Production Code:
ami = lookup(var.region_amis, var.region, "ami-default-ubuntu")
```

### 2. `merge()`: Enforcing Compliance Tags

**The Scenario**: Your Security Team requires **every** resource to have `CostCenter` and `SecurityTier`.
Developers only want to provide `Name` and `App`.

**The Solution**: You force a merge. You take the Security Team's Mandatory Tags and **overwrite/combine** them with the Developer's tags.

```hcl
locals {
  mandatory_tags = { CostCenter = "C-001", Security = "High" }
  dev_tags       = { Name = "MyApp", Env = "Dev" }

  # Security tags always applied automatically!
  final_tags = merge(local.mandatory_tags, local.dev_tags)
}
```

### 3. `zipmap()`: Creating Dynamic Dashboards

**The Scenario**: You just created 50 Web Servers using `count = 50`.
Terraform outputs a LIST of IDs `[i-1, i-2...]` and a LIST of IPs `[10.1, 10.2...]`.
Your Monitoring Tool (DataDog/CloudWatch) expects a **Map** to configure the dashboard: `{"i-1": "10.1"}`.

**The Solution**: Zip them together instantly.

```hcl
output "dashboard_config" {
  # Instantly connects every ID to its IP
  value = zipmap(aws_instance.web[*].id, aws_instance.web[*].private_ip)
}
```

## 🧪 How to Test

### 1. Initialize

```bash
terraform init
```

### 2. Test with Console

```bash
terraform console
```

Try these:

```hcl
> lookup({a="1", b="2"}, "c", "fallback")
"fallback"

> merge({a="1"}, {b="2"}, {a="99"})
{
  "a" = "99"
  "b" = "2"
}

> zipmap(["id1", "id2"], ["ip1", "ip2"])
{
  "id1" = "ip1"
  "id2" = "ip2"
}
```

### 3. Apply Code

```bash
terraform apply --auto-approve
```

Observe the `lookup_result` output.
Try changing `env` to "staging" in `variables.tf` and see it fall back to `t2.nano`.
