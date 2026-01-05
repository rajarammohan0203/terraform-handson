# Practical: Variable Default Values ⚙️

This exercise demonstrates the power of the `default` argument in variables. It allows your configuration to run "out of the box" while still being customizable.

## 🔑 Key Concepts
*   **The `default` argument**: Provides a fallback value.
*   **Optional inputs**: If a variable has a default, you **don't** have to provide a value when running `apply`.
*   **Overridable**: You can still override the default if you want.

## 🛠️ The Scenario
*   We defined `vpc_cidr` with a default of `10.50.0.0/16`.
*   We defined `instance_type` with a default of `t2.nano`.
*   We defined `enable_monitoring` with a default of `true`.

## 🚀 Steps to Run

### Experiment 1: Use Defaults (No arguments)
1.  Initialize:
    ```bash
    terraform init
    ```
2.  Apply **without** specifying any vars:
    ```bash
    terraform apply -auto-approve
    ```
3.  **Check Outputs**:
    *   `vpc_cidr_used` should be `10.50.0.0/16`.
    *   `instance_type_used` should be `t2.nano`.

### Experiment 2: Override Defaults
Change the behavior without changing the code!
1.  Run apply with a new value:
    ```bash
    terraform apply -var="instance_type=m5.large" -auto-approve
    ```
2.  **Check Outputs**:
    *   `instance_type_used` returns `m5.large`.
    *   `vpc_cidr_used` remains `10.50.0.0/16` (because we didn't override it).

## 🧹 Cleanup
```bash
terraform destroy -auto-approve
```
