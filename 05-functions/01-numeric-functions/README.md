# Numeric Functions

Terraform includes functions for number manipulation and math operations.

| Function  | Description                            | Example         | Result |
| :-------- | :------------------------------------- | :-------------- | :----- |
| `abs()`   | Absolute value (removes negative sign) | `abs(-15)`      | `15`   |
| `ceil()`  | Rounds **UP** to nearest integer       | `ceil(4.1)`     | `5`    |
| `floor()` | Rounds **DOWN** to nearest integer     | `floor(4.9)`    | `4`    |
| `max()`   | Returns the largest number             | `max(5, 10, 2)` | `10`   |
| `min()`   | Returns the smallest number            | `min(5, 10, 2)` | `2`    |

## 🌍 Real-World AWS Scenarios

| Function                 | Scenario                   | Use Case                                                               |
| :----------------------- | :------------------------- | :--------------------------------------------------------------------- |
| **`max(3, var.count)`**  | **High Availability (HA)** | "I requested 1 server, but HA policy says minimum 3."                  |
| **`min(10, var.count)`** | **Budget Control**         | "User tried to launch 50 servers! Limit them to 10 max."               |
| **`ceil(load / cap)`**   | **Capacity Planning**      | "Total load is 3.1. We can't have 3.1 servers, so we need 4."          |
| **`abs(diff)`**          | **Alerting**               | "Price changed by $10 (up or down). Trigger alert based on magnitude." |

## 🕹️ Test with Terraform Console (Interactive)

The best way to understand functions is using `terraform console`.

1. Run the console:

   ```bash
   terraform console
   ```

2. Try these commands (type them inside the console):

   **Test Max/Min Logic:**

   ```hcl
   > max(5, 12, 9)
   12
   > min(5, 12, 9)
   5
   # Nested logic: At least 3, At most 10.
   # Requesting 1 (Too low!) -> Becomes 3
   > min(10, max(3, 1))
   3
   # Requesting 50 (Too high!) -> Becomes 10
   > min(10, max(3, 50))
   10
   ```

   **Test Ceil (Rounding Up):**

   ```hcl
   > ceil(4.1)
   5
   > ceil(4.9)
   5
   ```

   **Test Floor (Rounding Down):**

   ```hcl
   > floor(4.9)
   4
   ```

3. Exit console:
   Type `exit` or press `Ctrl+D`

## 🧪 Run the Examples

### 1. Initialize

```bash
terraform init
```

### 2. Plan (Default: 2 instances requested)

```bash
terraform plan
```

**Observe**: `max(3, 2)` forces Terraform to create **3 instances**, ensuring HA compliance.

### 3. Test Limits

Request 100 instances!

```bash
terraform plan -var='requested_instances=100'
```

**Observe**: `min(10, ...)` forces limits to **10 instances**, preventing budget blowout.

### 4. Check Math Outputs

```bash
terraform apply --auto-approve
```

**Observe Outputs**:

- `capacity_planning`: "Load: 75.5 / 20 per server... Round UP to 4 servers"
- `price_change_alert`: "ALERT: Large Price Change detected ($15)"
- `conservative_cost_estimate`: "Actual: 99.99 -> Finance View: 99"

### 5. Clean Up

```bash
terraform destroy --auto-approve
```
