# Terraform Fundamentals & Workflow �

This guide covers the **"Why"** and **"How"** of Terraform, including core concepts and the commands to execute them.

---

## 🧐 Part 1: Core Concepts

### 1. Why Terraform?
**Problem**: Creating infrastructure manually (ClickOps) is slow, error-prone, and unrepeatable.
**Solution**: Terraform allows you to define infrastructure as code (IaC).
*   **Main Use Case**: Provisioning and managing lifecycle of cloud resources (EC2, S3, VPC) across multiple providers (AWS, Azure, Google) securely and predictably.

### 2. Authentication vs Authorization
Terraform needs permission to talk to your cloud provider.
*   **Authentication (Who are you?)**: Handling by Access Keys/Secret Keys or SSO profiles. Terraform uses your local AWS credentials (e.g., `~/.aws/credentials`).
*   **Authorization (What can you do?)**: Handled by IAM Policies attached to your user. If your user is "Read Only", Terraform cannot create an EC2 instance.

### 3. Desired State vs Current State ⚡
Terraform is **Declarative**. You tell it *what* you want, not *how* to do it.

*   **Desired State**: What you wrote in `main.tf`.
    > *I want 3 Servers.*
*   **Current State**: What actually exists in AWS.
    > *AWS has 1 Server running.*
*   **Terraform's Job**: Compare the two and calculate the difference.
    > *Plan: Create +2 Servers.*

### 4. Critical Files & Components

#### 🧠 The `terraform.tfstate` File
*   **Purpose**: This is Terraform's memory. It maps your code (`resource "aws_instance" "web"`) to the real world ID (`i-12345678`).
*   **Real-time Example**: You change a tag in code. Terraform looks at the state file, sees `i-12345678` already exists, and knows to just **update** it instead of creating a new one.
*   **Warning**: Never edit this file manually.

#### 🔒 The Login/Lock File (`.terraform.lock.hcl`)
*   **Purpose**: Consistency. It "locks" the exact version of the plugins you used.
*   **Real-time Example**: You use AWS Provider v4.0 today. Next year, v5.0 comes out with breaking changes. The lock file ensures your team still installs v4.0 so the code doesn't break.

#### 🔌 Providers & Versioning
*   **Provider**: A plugin that talks to a specific API (AWS, Azure, LocalStack).
*   **Versioning**:
    *   `version = "~> 4.0"`: Allows 4.1, 4.2 but **not** 5.0.
    *   **Why?**: Prevent updates from breaking your production code automatically.

---

## 🔄 Part 2: Workflow Commands

mastering the core workflow is the first step to becoming a Terraform expert.

### 1. terraform init
**Usage**: `terraform init`
*   **Concept**: Preparation. Downloads providers and modules.
*   **When to use**: New project, cloning repo, or adding a new provider.

### 2. terraform fmt
**Usage**: `terraform fmt`
*   **Concept**: Beautify.
*   **When to use**: Always. It fixes your messy spacing automatically.

### 3. terraform validate
**Usage**: `terraform validate`
*   **Concept**: Syntax Check.
*   **When to use**: To catch typos (e.g., `instanc_type`) before running a plan.

### 4. terraform plan
**Usage**: `terraform plan`
*   **Concept**: Dry Run / Preview.
*   **When to use**: **ALWAYS** before applying. Shows you exactly what will happen (+ create, - destroy, ~ update).

### 5. terraform apply
**Usage**: `terraform apply`
*   **Concept**: Make it happen.
*   **When to use**: When you are happy with the plan. It changes real infrastructure.

### 6. terraform destroy
**Usage**: `terraform destroy`
*   **Concept**: Nuke it.
*   **When to use**: Cleaning up a lab or removing a temporary environment.

### 7. terraform show
**Usage**: `terraform show`
*   **Concept**: Inspect Memory.
*   **When to use**: To read the `terraform.tfstate` file in a human-friendly way.

### 8. terraform output
**Usage**: `terraform output`
*   **Concept**: Get Data.
*   **When to use**: To get an IP address or DNS name that Terraform created.

### 9. terraform console
**Usage**: `terraform console`
*   **Concept**: Playground.
*   **When to use**: Testing math, variables, or functions interactively.

---

## 🎓 Practice Exercise
Go to the **03-first-ec2-instance** folder.
1.  Run `terraform plan`. Notice it checks the **State**?
2.  Run `terraform apply`. Watch it create the **Lock File**.
3.  Change the `instance_type` in code. Run `plan` again. Notice **Desired vs Current** comparison?
