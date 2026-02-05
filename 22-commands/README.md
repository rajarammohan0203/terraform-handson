# 24-commands: The Ultimate Terraform Reference

This guide covers CLI commands, workflows, and core concepts derived from your request and the provided screenshots.

---

## 1. CLI Commands (State & Operations)

### State Management (`terraform state`)

Surgical operations on your `terraform.tfstate` file.

- `terraform state list`:
  - **Usage**: List all resources tracked in the state file.
  - **Example**: `terraform state list` -> `aws_s3_bucket.my_bucket`
- `terraform state show <RESOURCE>`:
  - **Usage**: Show all attributes of a specific resource.
  - **Example**: `terraform state show aws_instance.web`
- `terraform state mv <SOURCE> <DEST>`:
  - **Usage**: Rename a resource in state without destroying it.
  - **Example**: `terraform state mv aws_instance.old aws_instance.new`
- `terraform state rm <RESOURCE>`:
  - **Usage**: Stop tracking a resource (remove from state) but **do not destroy** it in AWS.
  - **Example**: `terraform state rm aws_instance.legacy`
- `terraform state pull`:
  - **Usage**: Download the remote state (from S3/Cloud) and output to stdout.
  - **Example**: `terraform state pull > local-backup.tfstate`
- `terraform state push <FILE>`:
  - **Usage**: Upload a local state file to the remote backend (DANGEROUS).
  - **Example**: `terraform state push local-backup.tfstate`

### Import Workflow

Bringing existing infrastructure under Terraform control.

1.  **Identify Resource**: Get the ID (e.g., `i-12345`) from AWS Console/CLI.
2.  **Write Config**: Create a `resource "aws_instance" "legacy" {}` block (empty or partial).
3.  **Run Import**:
    ```bash
    terraform import aws_instance.legacy i-12345
    ```
4.  **Plan & Fix**: Run `terraform plan`. It will show errors if your config doesn't match reality. Fix `main.tf` until `plan` shows purely clean state (or use `ignore_changes`).

### Debugging

If Terraform crashes or behaves oddly, enable detailed logging.

- **Variables**:
  - `export TF_LOG=DEBUG` (or `TRACE`, `INFO`, `WARN`, `ERROR`)
  - `export TF_LOG_PATH=./terraform.log`
- **Usage**:
  ```bash
  export TF_LOG=TRACE
  terraform init
  # Check the terminal output for API calls
  ```

### Workspaces

Manage multiple environments (dev, stage, prod) with the same code but **different state files**.

- **Commands**:
  - `terraform workspace new <NAME>`: Create fresh state.
  - `terraform workspace select <NAME>`: Switch context.
  - `terraform workspace list`: Show all.
  - `terraform workspace show`: Show current.
- **Directory Structure**:
  - `default` workspace state is in `./terraform.tfstate`.
  - Named workspaces (e.g., `dev`) store state in `./terraform.tfstate.d/dev/terraform.tfstate`.

---

## 2. Meta-Arguments (Screenshot Analysis)

These are special arguments available to **every** resource type.

| Meta-Argument    | Description                                                                                                             |
| :--------------- | :---------------------------------------------------------------------------------------------------------------------- |
| **`depends_on`** | Handle hidden dependencies that Terraform can't see automatically. <br>Ex: `depends_on = [aws_s3_bucket.logger]`        |
| **`count`**      | Creates N instances of a resource (Integer loop). <br>Ex: `count = 3` -> `instance[0]`, `instance[1]`                   |
| **`for_each`**   | Creates an instance for each item in a Map or Set. <br>Ex: `for_each = toset(["admin", "user"])` -> `iam_user["admin"]` |
| **`lifecycle`**  | Modifies create/destroy behavior (see section 3).                                                                       |
| **`provider`**   | Overrides the default provider. <br>Ex: `provider = aws.europe` (for multi-region).                                     |

---

## 3. Lifecycle Arguments (Screenshot Analysis)

Arguments inside the `lifecycle {}` block to control safety and replacement.

| Argument                    | Description                                                                                                                                         |
| :-------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`create_before_destroy`** | Create the new resource _first_, then delete the old one. Useful for Zero-Downtime replacements (e.g., Launch Configurations).                      |
| **`prevent_destroy`**       | Hard error if Terraform tries to destroy this resource. Security safeguard for Databases (`true`).                                                  |
| **`ignore_changes`**        | Tell Terraform: "Don't fix this drift". Useful if an external system (or AWS AutoScaling) changes tags or counts. <br>Ex: `ignore_changes = [tags]` |
| **`replace_triggered_by`**  | Force replacement of Resource A if Resource B changes. <br>Ex: Replace EC2 instance if UserData file changes.                                       |

---

## 4. Built-in Functions (Screenshot Analysis)

Terraform DOES NOT support User-Defined Functions. You must use these built-ins.

| Category       | Available Functions                                                                                      |
| :------------- | :------------------------------------------------------------------------------------------------------- |
| **Numeric**    | `abs` (absolute), `ceil` (round up), `floor` (round down), `max`, `min`                                  |
| **String**     | `concat`, `replace`, `split`, `join`, `tolower`, `toupper`                                               |
| **Collection** | `element` (access by index), `keys` (map keys), `length` (size), `merge` (combine maps), `sort`, `slice` |
| **Filesystem** | `file` (read text), `filebase64` (read binary/zip), `dirname` (get path)                                 |

---

## 5. Module Registry Requirements (Screenshot Analysis)

If you want to publish a module to the **Public** Terraform Registry, you must strictly follow these rules:

1.  **Host**: Must be on **GitHub** (Public Repo).
2.  **Naming Convention**: `terraform-<PROVIDER>-<NAME>`
    - Correct: `terraform-aws-webserver`
    - Incorrect: `my-webserver`
3.  **Description**: Must have a GitHub Repository Description.
4.  **Structure**: Must have standard files (`main.tf`, `variables.tf`, `outputs.tf`) at the root.
5.  **Releases**: Must use **Git Tags** with specific SemVer format.
    - Correct: `v1.0.4`, `0.9.2`

_(Note: Private Registries inside HCP Terraform have looser requirements and don't require public GitHub repos)._
