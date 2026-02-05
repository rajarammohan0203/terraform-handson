# sentinel.hcl
# This file configures the policy set in HCP Terraform.
# usually, this file lives in a separate git repo called "policy-set".

policy "prevent-destroy" {
    source = "./prevent-destroy.sentinel"
    enforcement_level = "hard-mandatory"
}

# Enforcement Levels:
# 1. advisory: Warns user, but allows apply.
# 2. soft-mandatory: Blocks apply, but Org Admin can override.
# 3. hard-mandatory: Blocks apply. NO overrides.
