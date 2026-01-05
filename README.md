# Terraform Hands-On Learning Journey 🚀

Welcome to your structured path to mastering Terraform! This repository uses a **flat, topic-based structure** designed to help you practice one concept at a time.

## 🧭 How to Use This Repository

Each folder represents a specific topic. Start at `00` and work your way down.
**The rule is simple**: One topic = One folder.

### 📂 Repository Structure & Roadmap

| Folder | Focus Topic |
|--------|-------------|
| **`00-basics`** | Workflow essentials (`init`, `plan`, `apply`), First Resource |
| **`01-variables`** | Input variables, `tfvars`, validation |
| **`02-data-types`** | String, List, Map, Object, Tuple sets |
| **`03-locals`** | Local values for logic simplification |
| **`04-conditional-expressions`** | Ternary operators and conditionals |
| **`05-functions`** | Built-in functions (`try`, `merge`, `templatefile`) |
| **`06-count`** | Simple looping with `count` |
| **`07-for-each`** | Map/Set looping with `for_each` |
| **`08-dynamic-blocks`** | Generating nested blocks (security rules) |
| **`09-data-sources`** | Querying existing infrastructure |
| **`10-provider-versions`** | Managing provider constraints and aliases |
| **`11-backend`** | Remote state management (S3 + DynamoDB) |
| **`12-remote-state`** | Using `terraform_remote_state` data source |
| **`13-lifecycle`** | `create_before_destroy`, `ignore_changes` |
| **`14-modules`** | Creating and consuming reusable modules |
| **`15-import`** | Importing existing resources (`terraform import`) |
| **`16-state-commands`** | Advanced state surgery (`mv`, `rm`) |
| **`17-workspaces`** | Environment isolation with Workspaces |
| **`18-provisioners`** | `local-exec` and `remote-exec` (and why to avoid) |
| **`19-taint-and-replace`** | Forcing resource recreation |
| **`20-validate-fmt-plan`** | Code quality tools and deep dive on Plan |
| **`21-security-projects`** | **Capstone**: Security, Policies, and Final Project |

---

## 🎯 Learning Phases Mapping

Despite the flat structure, your learning journey still follows the core phases:

1.  **Foundations**: `00-basics` -> `06-count`
2.  **Logic & Scaling**: `07-for-each` -> `10-provider-versions`
3.  **State & Enterprise**: `11-backend` -> `17-workspaces`
4.  **Masters Tools**: `18-provisioners` -> `21-security-projects`

---

## 🛠 Prerequisites

1.  **Terraform Installed**: `v1.5+` recommended.
2.  **AWS CLI Configured**: Access to an AWS account.
3.  **VS Code**: With the *HashiCorp Terraform* extension.
