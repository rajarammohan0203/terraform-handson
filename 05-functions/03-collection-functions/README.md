# Collection Functions

Functions to manage **Lists** (Arrays) and **Maps** (Dictionaries/Objects).

| Function    | Description                     | Example                  | Result       |
| :---------- | :------------------------------ | :----------------------- | :----------- |
| `length()`  | Counts items in list/map        | `length(["a", "b"])`     | `2`          |
| `merge()`   | Combines maps                   | `merge({a=1}, {b=2})`    | `{a=1, b=2}` |
| `element()` | Gets item by index (**wraps!**) | `element(["a", "b"], 2)` | `"a"`        |
| `keys()`    | Gets keys from map              | `keys({a=1})`            | `["a"]`      |
| `sort()`    | Sorts a list                    | `sort(["b", "a"])`       | `["a", "b"]` |

## 🌍 Real-World AWS Scenarios

| Function        | Scenario               | Use Case                                                                                     |
| :-------------- | :--------------------- | :------------------------------------------------------------------------------------------- |
| **`merge()`**   | **Tagging Compliance** | "Security demands 5 global tags. App team wants 3 custom tags. Merge them on all resources." |
| **`element()`** | **HA Distribution**    | "Spread 10 instances across 3 Availability Zones (Round Robin: A, B, C, A, B...)."           |
| **`keys()`**    | **Validation**         | "Check if 'CostCenter' tag exists in the final map of tags."                                 |
| **`length()`**  | **Dynamic Counts**     | "Count how many subnets were passed to determine how many NAT Gateways to create."           |

## 🕹️ Test with Terraform Console (Interactive)

1. Run the console:

   ```bash
   terraform console
   ```

2. Try these commands:

   **Test Merging Maps:**

   ```hcl
   > merge({"env"="dev"}, {"owner"="team-a"})
   {
     "env" = "dev"
     "owner" = "team-a"
   }
   # Conflict resolution (Last one wins):
   > merge({"env"="dev"}, {"env"="prod"})
   {
     "env" = "prod"
   }
   ```

   **Test Round-Robin Logic:**

   ```hcl
   > element(["subnet-a", "subnet-b"], 0)
   "subnet-a"
   > element(["subnet-a", "subnet-b"], 1)
   "subnet-b"
   > element(["subnet-a", "subnet-b"], 2)  # Loop!
   "subnet-a"
   ```

   **Test Keys/Length:**

   ```hcl
   > length(["a", "b", "c"])
   3
   > keys({"name"="app", "role"="server"})
   [
     "name",
     "role",
   ]
   ```

3. Exit with `exit`.

## 🧪 Run the Examples

### 1. Initialize

```bash
terraform init
```

### 2. Apply and Check Outputs

```bash
terraform apply --auto-approve
```

**Observe Outputs**:

- `compliance_tag_check`: See how common + project tags merged.
- `tag_keys_present`: List of all tag keys.

**Check Terraform State for Instances**:

```bash
terraform state list aws_instance.ha_cluster
```

You will see 5 instances created. Check their AZs in the console output or usage `terraform show`. You'll see they cycle through the AZs (Round Robin).

### 3. Clean Up

```bash
terraform destroy --auto-approve
```
