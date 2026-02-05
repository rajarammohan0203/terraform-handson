# 04-sentinel-aws-example: Real World Enforcement

## Scenario

The Finance team wants to prevent developers from accidentally spinning up expensive `c5.4xlarge` servers.
We use Sentinel to enforce that only "Micro" and "Small" instances are allowed.

## The Mock Data (`tfplan/v2`)

Sentinel inspects the `tfplan` data. It looks something like this (simplified):

```json
{
  "resource_changes": [
    {
      "type": "aws_instance",
      "change": {
        "actions": ["create"],
        "after": {
          "instance_type": "c5.4xlarge"  <--- SENTINEL SEES THIS
        }
      }
    }
  ]
}
```

## Outcome

If a developer writes `instance_type = "c5.4xlarge"`, the `terraform plan` succeeds, but the **Policy Check** fails immediately after, blocking the Apply.
