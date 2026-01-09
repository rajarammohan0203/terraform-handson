# ---------------------------------------------------------------------------------------------------------------------
# FILESYSTEM FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------
# Interact with the local filesystem.
# Common functions: file(), filebase64(), dirname(), abspath()

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 1: FILE (Separating Logic from Config)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You need to run a 50-line shell script on EC2 boot.
# BAD: Putting 50 lines of shell script inside your .tf file (HARD to read/test).
# GOOD: Write it in `script.sh` (easy to test mostly), then load it with file().

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # Reads content of script.sh
  user_data = file(var.script_path)

  tags = {
    Name = "server-with-script"
    Desc = "Loaded from external file"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 2: FILEBASE64 (Lambda & Binary Data)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: Deploying an AWS Lambda function.
# AWS requires the deployment package (zip file) to be Base64 encoded if passed inline (or hash checking).
# file() returns distinct text. filebase64() handles binary/encoding for you.

output "encoded_script_for_lambda" {
  value       = filebase64(var.script_path)
  description = "Simulates how you would pass a zip file to Lambda"
}

# ---------------------------------------------------------------------------------------------------------------------
# EXAMPLE 3: DIRNAME & ABSPATH (Module Paths)
# ---------------------------------------------------------------------------------------------------------------------
# SCENARIO: You are writing a Reusable Module.
# You need to reference a file RELATIVE to the module, not where Terraform is running.
# `path.module` is usually best, but `dirname` helps traverse trees.

output "debug_paths" {
  value = {
    script_directory = dirname(var.script_path) # Where does the script live?
    full_path        = abspath(var.script_path) # Exact location on disk
    file_content     = file(var.script_path)    # Preview content
  }
}
