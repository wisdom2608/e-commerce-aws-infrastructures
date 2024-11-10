# Create a load balancer (ALB)
resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_az1_id, var.public_subnet_az2_id]

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
    env: var.environment
  }
}

# Create a target group
resource "aws_lb_target_group" "wisdom-tg" {
  name     = "wisdom-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id


  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  
    stickiness {
    type            = "lb_cookie"  # Use "source_ip" for Network Load Balancers
    cookie_duration = 86400        # Duration in seconds (1 day in this case)
    enabled = true 
  }
  tags = {
    Name = "${var.project_name}-tg"
    env: var.environment
}
}

# Create a load balancer listener
resource "aws_lb_listener" "wisdom-listerner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wisdom-tg.arn
  }
}


# Register EC2 instances with the target group
resource "aws_lb_target_group_attachment" "wisdom_alb_attach_1" {
  target_group_arn = aws_lb_target_group.wisdom-tg.arn
  target_id        = var.appserver-1_id
  port             = 80
}
#Application load balancer and tg attachment
resource "aws_lb_target_group_attachment" "wisdom_alb_attach_2" {
  target_group_arn = aws_lb_target_group.wisdom-tg.arn
  target_id        = var.appserver-2_id
  port             = 80
}


