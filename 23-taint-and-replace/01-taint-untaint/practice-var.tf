# Practice!
# 1. Taint the random_id resource: `terraform taint random_id.server_id`
# 2. Run plan.
# 3. Notice that because random_id is tainted, the aws_instance ALSO gets recreated?
#    Why? Because `aws_instance` depends on `random_id.hex`.
#    This is called "Cascading Destruction".
