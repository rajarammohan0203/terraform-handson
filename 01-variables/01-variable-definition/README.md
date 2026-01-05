# Practical: Intro to Input Variables 📦

Hardcoding values (like `10.0.0.0/16`) makes code rigid. Variables make it **reusable**.

## 🔑 Key Concepts
*   **Variable Block**: Defined in `variables.tf`.
*   **Accessing**: Use `var.variable_name` in `main.tf`.
*   **Default Value**: Used if you don't provide one.
*   **Interpolation**: Inserting a variable into a string: `"Name-${var.os_name}"`.

## 🛠️ The Code Structure
1.  **`variables.tf`**: We define `vpc_cidr` and `instance_type` here.
2.  **`main.tf`**: We *use* them here.

## 🚀 Steps to Run
1.  Initialize:
    ```bash
    terraform init
    ```
2.  Plan (See the default values being used):
    ```bash
    terraform plan
    ```
    *Look for `cidr_block = "10.0.0.0/16"`.*

3.  Apply with **Overrides** (The power of variables!):
    You can change the value *without changing the code*.
    ```bash
    terraform apply -var="instance_type=t2.small" -var="os_name=Ubuntu" -auto-approve
    ```

4.  Verify in LocalStack:
    ```bash
    AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
    aws --endpoint-url=http://localhost:4566 ec2 describe-instances --region us-east-1
    ```
    *Check the Tags: Name should be `Server-Running-Ubuntu`.*

## 🧹 Cleanup
```bash
terraform destroy -auto-approve
```
