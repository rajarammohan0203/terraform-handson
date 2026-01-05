# Practical: Creating an Elastic IP 📍

An **Elastic IP (EIP)** is a static IPv4 address designed for dynamic cloud computing.

## 🔑 Key Concepts
*   **Static IP**: Does not change when you stop/start resources (unlike standard public IPs).
*   **Cost**: AWS usually charges for EIPs if they are *not* attached to a running instance (to discourage hoarding). In LocalStack, it's free.

## 🚀 Steps to Run
1.  `terraform init`
2.  `terraform apply -auto-approve`
3.  Verify:
    ```bash
    AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test \
    aws --endpoint-url=http://localhost:4566 ec2 describe-addresses --region us-east-1
    ```

You will see an output like `"PublicIp": "127.0.0.1"` (LocalStack usually mimics this or a random IP).
