# String Functions

Essential for **Naming Conventions**, **Tagging Standards**, and **Input Cleaning**.

| Function    | Description                 | Example                    | Result       |
| :---------- | :-------------------------- | :------------------------- | :----------- |
| `tolower()` | Converts to lowercase       | `tolower("Hi")`            | `"hi"`       |
| `toupper()` | Converts to uppercase       | `toupper("hi")`            | `"HI"`       |
| `replace()` | Replaces substrings         | `replace("a-b", "-", "_")` | `"a_b"`      |
| `split()`   | Splits string into **LIST** | `split(",", "a,b")`        | `["a", "b"]` |
| `concat()`  | Combines **LISTS**          | `concat(["a"], ["b"])`     | `["a", "b"]` |

## 🌍 Real-World AWS Scenarios

| Function        | Scenario           | Use Case                                                                          |
| :-------------- | :----------------- | :-------------------------------------------------------------------------------- |
| **`tolower()`** | **S3 Compliance**  | "User passed 'MyBucket'. S3 requires lowercase. We fix it to 'mybucket'."         |
| **`toupper()`** | **Tagging Policy** | "Env tags must be 'DEV' or 'PROD'. User passed 'dev'. We fix it to 'DEV'."        |
| **`replace()`** | **Sanitization**   | "User passed 'My Project'. DNS names can't have spaces. We make it 'My-Project'." |
| **`split()`**   | **Input Parsing**  | "Env vars come as strings ('10.1,10.2'). We need a list to use `count`."          |

## 🕹️ Test with Terraform Console (Interactive)

1. Run the console:

   ```bash
   terraform console
   ```

2. Try these commands:

   **Test Case Conversion:**

   ```hcl
   > tolower("MyBucketName")
   "mybucketname"
   > toupper("production")
   "PRODUCTION"
   ```

   **Test Replacement:**

   ```hcl
   > replace("invalid name with spaces", " ", "-")
   "invalid-name-with-spaces"
   ```

   **Test Splitting Strings:**

   ```hcl
   > split(",", "subnet-1,subnet-2,subnet-3")
   [
     "subnet-1",
     "subnet-2",
     "subnet-3",
   ]
   ```

3. Exit with `exit`.

## 🧪 Run the Examples

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan
```

**Observe**:

- S3 Bucket Name: `my-super-project` (Lowercased automatically!)
- Tags: Environment=`DEV` (Uppercased automatically!)
- Subnet Count: 3 (String split into list!)

### 3. Apply and Check Outputs

```bash
terraform apply --auto-approve
```

**Observe `debug_steps` output**:

- Shows exactly how the string changed at each step.

### 4. Clean Up

```bash
terraform destroy --auto-approve
```
