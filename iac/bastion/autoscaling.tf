resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-0dfdff9941ebfbd48"
  instance_type = "t2.micro"
}
//Minimum 1 instances, scale up to 2  based on CPU and memory usage.

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["eu-west-3a", "eu-west-3b"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}