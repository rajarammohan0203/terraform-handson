# ---------------------------------------------------------------------------------------------------------------------
# SPLAT EXPRESSIONS ([*])
# ---------------------------------------------------------------------------------------------------------------------
# Use [*] to get a specific attribute from ALL resources created with count

# Create multiple EC2 instances
resource "aws_instance" "web_servers" {
  count = var.instance_count

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "web-server-${count.index}"
  }
}

# Create multiple S3 buckets
resource "aws_s3_bucket" "data_buckets" {
  count  = var.bucket_count
  bucket = "data-bucket-${count.index}"
}

# ---------------------------------------------------------------------------------------------------------------------
# SPLAT EXPRESSIONS IN ACTION
# ---------------------------------------------------------------------------------------------------------------------

# WITHOUT SPLAT: Get one specific instance ID
output "first_instance_id" {
  value = aws_instance.web_servers[0].id
  #       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #       Gets ID of the FIRST instance only
}

# WITH SPLAT: Get ALL instance IDs at once
output "all_instance_ids" {
  value = aws_instance.web_servers[*].id
  #       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #       [*] means "get .id from ALL instances"
}

# Get ALL instance names
output "all_instance_names" {
  value = aws_instance.web_servers[*].tags.Name
  #       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #       Gets the Name tag from ALL instances
}

# Get ALL bucket names
output "all_bucket_names" {
  value = aws_s3_bucket.data_buckets[*].bucket
  #       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #       Gets bucket name from ALL buckets
}

# Get ALL bucket ARNs
output "all_bucket_arns" {
  value = aws_s3_bucket.data_buckets[*].arn
}

# ---------------------------------------------------------------------------------------------------------------------
# PRACTICAL USE CASE
# ---------------------------------------------------------------------------------------------------------------------

# Count how many instances were created
output "total_instances" {
  value = length(aws_instance.web_servers[*].id)
  #       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #       length() counts items in the list
}

# Create a formatted message with all IPs
output "instance_summary" {
  value = "Created ${length(aws_instance.web_servers)} instances with IDs: ${join(", ", aws_instance.web_servers[*].id)}"
  #                                                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  #                                                                           join() combines all IDs with commas
}
