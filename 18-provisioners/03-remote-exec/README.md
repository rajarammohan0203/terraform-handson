# Provisioner: remote-exec

Run scripts **inside** the new server.

## ☠️ The "Taint" Behavior
This is the most critical concept to understand with Provisioners.
If a creation-time provisioner fails:
1.  Terraform stops.
2.  It marks the resource as **Tainted**.
3.  Why? Because the resource exists (ID created), but the software setup failed. It's in an unknown, broken state.
4.  **Consequence**: The next `terraform apply` will forcefully **Destroy and Recreate** it to try again.

## 🌍 Real-World AWS Scenario
**Post-Install Steps**:
After the instance boots:
1.  Update OS patches (`apt-get update`).
2.  Install Application.
3.  Start Service.
If step 2 fails, you don't want a "zombie" server with no app. You want Terraform to kill it and retry.

## 🧪 How to Test
Like `file`, this requires real SSH networking.
Use `local-exec` for easy LocalStack testing. Use `remote-exec` on real AWS/Azure environments.
