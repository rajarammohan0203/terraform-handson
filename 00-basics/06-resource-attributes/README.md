# Practical: Attributes & Cross-Referencing 🔗

The real power of Terraform comes when you connect resources together. This is **"Attribute Referencing"**.

## 🔑 Key Concepts
*   **Attributes**: Every resource has properties (ID, IP, ARN) that available *after* creation.
*   **The Syntax**: `resource_type.resource_name.attribute`
    *   Example: `aws_s3_bucket.my_bucket.id`
*   **Implicit Dependency**: When Resource B uses an attribute from Resource A, Terraform knows it must create A *before* B.

## 📝 The Plan Explanation
When you run `terraform plan`, verify the **dependencies**:

1.  **Security Group** (`aws_security_group.my_sg`) -> Created first (needs no IDs).
2.  **Elastic IP** (`aws_eip.my_vip`) -> Created independently.
3.  **Instance** (`aws_instance.app_server`) -> **Depends on SG**.
    *   Look for: `vpc_security_group_ids = [ (known after apply) ]`
    *   This "known after apply" means it's waiting for the SG to be created to get its ID.
4.  **Association** (`aws_eip_association.eip_assoc`) -> **Depends on Instance + EIP**.
    *   It binds the two together.

## 🚀 Steps to Run & Verify

### 1. Apply
```bash
terraform init
terraform apply -auto-approve
```

### 2. Verify with AWS CLI (LocalStack)
Check if the instance actually has the Security Group and IP attached.

**A. Check the Instance (Look for 'SecurityGroups' and 'PublicIpAddress')**
```bash
AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
aws --endpoint-url=http://localhost:4566 ec2 describe-instances --region us-east-1
```
*Expected*: matching `GroupId` and `PublicIp`.

**B. Check the Elastic IP Association**
```bash
AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
aws --endpoint-url=http://localhost:4566 ec2 describe-addresses --region us-east-1
```
*Expected*: `InstanceId` should match your created instance.

**C. Check the Security Group**
```bash
AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
aws --endpoint-url=http://localhost:4566 ec2 describe-security-groups --region us-east-1
```

## 📤 Outputs
Outputs are like "Return Values" in programming. They print important information to the console after `terraform apply`.

In `main.tf`, we defined:
```hcl
output "instance_id" {
  value = aws_instance.app_server.id
}
```
This tells Terraform: *"After you create the server, grab its ID and show it to me."*

### How to use Outputs
1.  **After Apply**: They are printed at the very end of the `apply` output.
2.  **Programmatic Access**: You can run `terraform output` to see them anytime.
    ```bash
    terraform output
    # Returns:
    # instance_id = "i-1234..."
    # public_ip   = "1.2.3.4"
    ```
3.  **Specific Value**:
    ```bash
    terraform output public_ip
    # Returns: "1.2.3.4"
    ```

## 🧹 Cleanup
```bash
terraform destroy -auto-approve
```
