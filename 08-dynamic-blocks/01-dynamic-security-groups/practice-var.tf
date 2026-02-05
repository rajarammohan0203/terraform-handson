# Practice!
# 1. Run `terraform plan`.
# 2. Add port 3000 to the default list in variables.tf.
# 3. Configure a Complex Object instead of a simple number list.
#    Example Variable:
#    [
#      { port = 80, description = "HTTP" },
#      { port = 443, description = "HTTPS" }
#    ]
#    Then update main.tf to use `ingress.value.port` and `ingress.value.description`.
