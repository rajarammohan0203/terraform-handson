resource "aws_launch_configuration" "app" {
  image_id      = "ami-12345678"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app.name
  min_size             = 1
  max_size             = 3
  availability_zones   = ["us-east-1a"]

  # DYNAMIC BLOCK: Tags
  # Transforms the simple 'var.custom_tags' map into the complex block structure required by ASG.

  dynamic "tag" {
    for_each = var.custom_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true # We want all tags to appear on the EC2 instances
    }
  }

  tag {
    key                 = "Name"
    value               = "ASG-Instance-Static"
    propagate_at_launch = true
  }
}
