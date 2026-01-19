# Provisioner: local-exec

Run commands on **your** machine (the Host), not the server.

## 🔑 Key Concepts

### 1. Creation-Time vs Destroy-Time
*   **Creation-Time** (Default): Runs during `apply`. If it fails, the resource is **Tainted** (marked for destruction next time) because Terraform assumes the setup failed.
*   **Destroy-Time** (`when = destroy`): Runs during `destroy`. Useful for cleanup. If it fails, Terraform **Stops** the destroy (the resource stuck in state).

### 2. Failure Handling (`on_failure`)
*   `fail` (Default): Stops Terraform immediately.
*   `continue`: Logs the error but continues the apply. (Use when the script isn't critical).

## 🌍 Real-World AWS Scenario
**Ansible Inventory Generation**:
Terraform creates the infrastructure (IP addresses).
Ansible configures it.
You use `local-exec` to write the new IP addresses into an `inventory.ini` file so Ansible knows where to connect.

## 🧪 How to Test
1.  `terraform apply`
2.  `cat inventory.txt` (See the IP).
3.  `terraform destroy`
4.  `cat destroy_log.txt` (See the cleanup log).
