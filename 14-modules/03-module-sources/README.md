# Module Sources

Checking out code from different locations.

## 1. Local Paths (`./` or `../`)

- **Use Case**: Development, Monorepos.
- **Speed**: Fastest (no download).
- **Syntax**: `source = "../modules/vpc"`

## 2. Terraform Registry (`terraform-aws-modules/vpc/aws`)

- **Use Case**: Using open-source, community-verified modules.
- **Registry**: [registry.terraform.io](https://registry.terraform.io/)
- **Syntax**: `source = "NAMESPACE/NAME/PROVIDER"`
- **Tip**: Always set `version = "x.y.z"` to avoid breaking changes.

## 3. Git Repositories (`git::https://...`)

- **Use Case**: Private Company Modules. Sharing code between teams.
- **Syntax**: `source = "git::https://github.com/acme/infra-modules.git//modules/vpc?ref=v1.0.0"`
- **Key Details**:
  - `//`: Tells Terraform to look inside a _specific folder_ of the repo.
  - `?ref=v1.0.0`: **Pinned Version**. You can use a Branch Name (`main`), Tag (`v1.0`), or Commit ID (`a1b2c3d`). **ALWAYS** use tags for production stability.

## 4. HTTPS / S3 / GCS

- **Use Case**: Storing module artifacts as Zip files in secure storage.
