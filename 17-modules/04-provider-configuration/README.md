# Provider Configuration in Modules

How to handle Multi-Region or Multi-Account setups within modules.

## 🛑 The Golden Rule

**NEVER** define `provider "aws" { ... }` inside a Child Module.
Why? Because it makes the module hard-coded. You can't remove it easily, and you can't customize it.

## ✅ The Solution: `configuration_aliases`

1.  **In Child Module**: Declare that you expect a provider.
    ```hcl
    terraform {
      required_providers {
        aws = {
          configuration_aliases = [ aws.src, aws.dst ]
        }
      }
    }
    ```
2.  **In Root Module**: Pass the providers explicitly.
    ```hcl
    module "example" {
      source = "./module"
      providers = {
        aws.src = aws.us_east_1
        aws.dst = aws.us_west_2
      }
    }
    ```

## 🌍 Real-World Scenario

**Cross-Region Replication (S3)**:
You need a bucket in US-EAST-1 and a replica in EU-WEST-1.
A single Terraform Apply needs to talk to **two different regions**.
Modules allow you to package this logic cleanly using Aliased Providers.
