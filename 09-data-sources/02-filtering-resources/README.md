# Data Sources: Filtering & Searching

This is the most powerful feature of Data Sources: **Finding existing things.**
Instead of hardcoding IDs (`ami-0123...`, `vpc-abc...`), you search for them dynamically.

| Data Source  | Question it Answers              | Use Case                                                                |
| :----------- | :------------------------------- | :---------------------------------------------------------------------- |
| `aws_ami`    | **What is the latest OS image?** | "Find the latest Ubuntu 20.04 AMI so I don't have to update ID weekly." |
| `aws_vpc`    | **Where is the network?**        | "Find the VPC tagged 'Production' so I can put my server there."        |
| `aws_subnet` | **Which subnet to use?**         | "Find the subnet in us-east-1a specific to that VPC."                   |

## 🌍 Real-World AWS Scenario

**The Problem:**
AWS releases new AMI IDs for Ubuntu/Linux regularly (security patches).
If you hardcode `ami-0c55...` in your code, your server will be outdated in a month.

**The Solution:**
Use `data "aws_ami"` to filter for the **most recent** image matching a name pattern.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "app" {
  ami = data.aws_ami.ubuntu.id # Always gets the latest!
}
```

## 🧪 How to Test

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- Terraform will Query the API (LocalStack) to find the AMI.
- It will display the specific AMI ID it found (e.g., `ami-df5...`).
- It will find the default VPC ID.

### 3. Apply

```bash
terraform apply --auto-approve
```

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
