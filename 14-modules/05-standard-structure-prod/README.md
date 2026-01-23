# Production Module Structure

How to scale to 3+ AWS Accounts and 100+ Resources.

## 🏗 The "Golden" Directory Layout

Separate your **Code** (Configuration) from your **Values** (Live Data).

```
.
├── modules/                 (The Library - "Code")
│   ├── vpc/                 # Standard VPC
│   ├── eks-cluster/         # Standard K8s
│   └── rds-postgres/        # Standard DB
│
└── live/                    (The Usage - "Value")
    ├── dev/                 (Account 1)
    │   └── us-east-1/
    │       ├── vpc/         # Calls code from ../modules/vpc
    │       └── app/
    ├── stage/               (Account 2)
    └── prod/                (Account 3)
```

## 🔑 Why this works for Production?

1.  **DRY (Don't Repeat Yourself)**: The complex logic lives in `modules/`. The `live/` folders are tiny files that just pass variables.
2.  **Version Control**: You can pin `prod` to `v1.0` and test `v1.1` in `dev` safely using Git tags in the source URL.
3.  **Blast Radius**: Each folder in `live` (`live/dev/vpc`) has its own **State File**. If you break the VPC state, you don't break the Database state.

## 🧪 How to Practise

Go to `live/dev/us-east-1/vpc` and run `terraform init` and `apply`.
This simulates a developer deploying the standard VPC into the Dev Account.
