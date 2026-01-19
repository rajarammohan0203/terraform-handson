# Provisioner: file

Copy files and directories to the newly created resource.

## ⚠️ The Last Resort
HashiCorp recommends using **`user_data` (EC2)** or **Packer (AMI)** instead of provisioners where possible.
Provisioners require:
1.  Open SSH ports (Security Risk).
2.  Complex Connection Blocks.
3.  Waiting for SSH to be ready (Slows down apply).

## 🌍 Real-World AWS Scenario
**Uploading Configs**:
You have a specific `nginx.conf` that is generated dynamically.
You use the `file` provisioner to push it to `/etc/nginx/nginx.conf` before starting the service.

## 🧪 How to Test
**Warning**: Requires real SSH connectivity (hard with standard LocalStack).
This code demonstrates the *syntax* and *structure* correctly.
To make it actually work, you need an EC2 instance reachable via SSH from your terminal.
