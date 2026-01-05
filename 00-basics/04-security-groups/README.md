# Practical: Working with Security Groups 🛡️

In AWS, a **Security Group** acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic.

## 🔑 Key Concepts
*   **Ingress**: Incoming traffic rules (e.g., allow users to see your website on port 80).
*   **Egress**: Outgoing traffic rules (e.g., allow server to download updates).
*   **CIDR `0.0.0.0/0`**: Means "Anywhere" / "The whole internet".

## 🚀 Steps to Run
1.  Initialize: `terraform init`
2.  Plan: `terraform plan`
3.  Apply: `terraform apply -auto-approve`
4.  Verify:
    ```bash
    AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
    aws --endpoint-url=http://localhost:4566 ec2 describe-security-groups --region us-east-1
    ```

## 🧠 Things to Observe
*   Notice the `ingress` blocks allow specific ports (443, 80).
*   Notice the `egress` block allows `-1` (all traffic) out. This is standard practice.
