# 03-sentinel-policy-overview: Policy as Code

## What is Sentinel?

Sentinel is an embedded policy-as-code framework integrated into HCP Terraform.
It runs **between** the `Plan` and `Apply` phases.

`Plan` -> `Sentinel Check` -> (If Pass) -> `Apply`

## Syntax

It uses its own language (Sentinel). It's designed to be readable by non-programmers (Compliance teams).

## How to use this example

1.  You cannot run this locally with `terraform apply`.
2.  Sentinel runs on the Cloud Platform.
3.  To test this, you would:
    - Create a "Policy Set" in HCP Terraform.
    - Connect it to this folder (in a git repo).
    - Try to destroy a resource in a workspace.
    - See the run FAIL with "prevent-destroy failed".
