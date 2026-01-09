# Filesystem Functions

Interact with files on the machine running Terraform.

| Function       | Description                          | Example                  | Result                   |
| :------------- | :----------------------------------- | :----------------------- | :----------------------- |
| `file()`       | Reads file content as string         | `file("script.sh")`      | `"#!/bin/bash..."`       |
| `filebase64()` | Reads file and returns Base64 string | `filebase64("app.zip")`  | `"UEsDBBQ..."`           |
| `dirname()`    | Gets directory path of a file        | `dirname("/a/b/c.txt")`  | `"/a/b"`                 |
| `abspath()`    | Gets full absolute path              | `abspath("./script.sh")` | `"/Users/.../script.sh"` |

## 🌍 Real-World AWS Scenarios

| Function           | Scenario              | Use Case                                                                          |
| :----------------- | :-------------------- | :-------------------------------------------------------------------------------- |
| **`file()`**       | **EC2 User Data**     | "Load a 100-line shell script from `install.sh` instead of hardcoding it in HCL." |
| **`filebase64()`** | **Lambda Deployment** | "Read `function.zip` and encode it for AWS Lambda source code."                   |
| **`abspath()`**    | **Debugging**         | "Where exactly is Terraform looking for my config file? Print the full path."     |

## 🕹️ Test with Terraform Console (Interactive)

1. Run the console:

   ```bash
   terraform console
   ```

2. Try these commands:

   **Test Reading Files:**

   ```hcl
   # Read the provider file (it exists!)
   > file("provider.tf")
   ...content of provider.tf...

   # Try to read a missing file (Errors!)
   > file("missing.txt")
   Error: ...
   ```

   **Test Path Manipulation:**

   ```hcl
   > dirname("/Users/jdoe/projects/terraform/main.tf")
   "/Users/jdoe/projects/terraform"

   > basename("/Users/jdoe/projects/terraform/main.tf")
   "main.tf"
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

- `debug_paths`: Shows the absolute path vs relative directory.
- `encoded_script`: Returns the Base64 string (simulating binary data).

### 3. Check LocalStack

```bash
aws --endpoint-url=http://localhost:4566 ec2 describe-instance-attribute --instance-id <INSTANCE_ID> --attribute userData
```

_Note: The user data in AWS output is also base64 encoded by default._

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
