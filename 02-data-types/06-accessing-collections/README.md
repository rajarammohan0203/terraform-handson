# Accessing Collections: Lists and Maps

This folder demonstrates how to **fetch/access data** from lists and maps in Terraform.

## Purpose

When you have a collection of data, you often need to:

- **Get a specific item** (first subnet, last zone, specific tag)
- **Transform data** (convert all values to uppercase, add prefixes)
- **Extract keys or values** (get all tag names, get all port numbers)

## Real-World Scenarios

### 1. Accessing Lists by Index

**Scenario**: You have a list of subnet CIDRs and need to assign specific ones to specific resources.

```hcl
var.subnet_cidrs[0]  # First subnet: "10.0.1.0/24"
var.subnet_cidrs[1]  # Second subnet: "10.0.2.0/24"
```

**Use Case**: Creating subnets in specific availability zones, assigning IPs in order.

### 2. Accessing Maps by Key

**Scenario**: You have a map of tags and need to apply specific tags to resources.

```hcl
var.instance_tags["Environment"]  # "Development"
var.instance_tags["Project"]      # "TerraformLearning"
```

**Use Case**: Applying consistent tags, looking up region-specific AMI IDs.

### 3. Transforming Collections

**Scenario**: You need to modify all items in a collection.

```hcl
[for cidr in var.subnet_cidrs : "subnet-${cidr}"]
{ for k, v in var.tags : k => upper(v) }
```

**Use Case**: Adding prefixes, converting formats, filtering data.

## When to Use

| Operation                | Use When                                      |
| :----------------------- | :-------------------------------------------- |
| **Index Access** `[0]`   | You need a specific item from an ordered list |
| **Key Access** `["key"]` | You need a specific value from a map          |
| **`length()`**           | You need to know how many items exist         |
| **`keys()`**             | You need all the keys from a map              |
| **`values()`**           | You need all the values from a map            |
| **`for` expression**     | You need to transform or filter data          |

## ⚠️ Limitations

| Issue             | Problem                                               | Solution                                    |
| :---------------- | :---------------------------------------------------- | :------------------------------------------ |
| **Out of Bounds** | Accessing `var.list[10]` when list has only 3 items   | Use `length()` to check size first          |
| **Missing Key**   | Accessing `var.map["missing"]` when key doesn't exist | Use `lookup(var.map, "key", "default")`     |
| **Immutability**  | Can't modify variables directly                       | Use `locals` to create transformed versions |

## 🧪 How to Test (Step-by-Step)

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- Subnets using `var.subnet_cidrs[0]` and `[1]`
- Instance tags using `var.instance_tags["Environment"]`
- Outputs showing accessed values

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Verify Outputs

```bash
terraform output
```

You'll see:

- `first_subnet_cidr` = "10.0.1.0/24"
- `environment_tag` = "Development"
- `all_tag_keys` = ["Environment", "Project", "Owner", "CostCenter"]

### 5. Verify in LocalStack

**Check Subnets**:

```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-subnets
```

**Check Instance**:

```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-instances
```

### 6. Test Practice Exercises

Uncomment exercises in `practice-var.tf` and run:

```bash
terraform validate
terraform plan
```

### 7. Destroy

```bash
terraform destroy --auto-approve
```

## 📝 Practice Exercises

The `practice.tf` file contains exercises for:

1. Accessing specific items from a list of availability zones
2. Accessing specific values from a map of ports
3. Using `for` expressions to transform data

Complete the exercises and test them!
