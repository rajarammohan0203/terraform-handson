# 1. Read the Remote State from Layer 1
data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    # Path to the Layer 1 state file
    # In S3 backend, this would cover bucket, key, region etc.
    path = "${path.module}/../layer1-network/terraform.tfstate"
  }
}

# 2. Use the Output from Layer 1
resource "aws_instance" "app_server" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"

  # Accessing the output!
  subnet_id = data.terraform_remote_state.network.outputs.subnet_id

  tags = {
    Name = "App-in-Shared-VPC-${data.terraform_remote_state.network.outputs.vpc_id}"
  }
}
