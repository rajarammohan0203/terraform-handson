# 06-private-registry-airgap

## Private Registry

HCP Terraform acts as a private version of the public Terraform Registry.
You upload your modules there, and your team consumes them using the `app.terraform.io/ORG/MODULE` syntax.

## Air-Gapped Environments

Some highly regulated industries (Banking, Defense) act in "Air-Gapped" networks (Strictly No Internet Access).

**How does Terraform work there?**

1.  **HCP Terraform** is usually SaaS (Internet).
2.  **Terraform Enterprise (TFE)** is the Self-Hosted version. You install it on your own servers INSIDE the air-gap.
3.  **Private Registry in TFE**: Since you can't reach the public registry, you upload ALL provider plugins (AWS, Azure) and Modules to your internal TFE Private Registry.
4.  Terraform assumes the internal registry is the source of truth.
