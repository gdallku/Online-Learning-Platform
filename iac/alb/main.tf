variable "vpc_id" {}
variable "public_subnet-1a_id" {}
variable "public_subnet-1b_id" {}
variable "aws_security_group_id" {}


resource "aws_lb" "test" {
  name               = "Appliaction Load Balancer for OLN"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.aws_security_group_id]
  subnets            = [var.public_subnet-1a_id,var.public_subnet-1b_id]

  enable_deletion_protection = true
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "alb-example" {
  name        = "Appliaction Load Balancer for OLN-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}




# # Application Load balancer
# resource "aws_lb" "test" {
#   name               = "alb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group_id.ssh_access.id]
#   subnets            = [public_subnet-1a_id,public_subnet-1b_id]

#   tags = {
#     Environment = "production"
#   }
# }