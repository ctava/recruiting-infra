resource "aws_alb" "ui" {
  name            = var.ui_lb_name
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.ui_lb.id]
}

resource "aws_alb_target_group" "ui" {
  name        = var.ui_lb_target_group_name
  port        = var.http_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "ui" {
  load_balancer_arn = aws_alb.ui.id
  port              = var.ui_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ui.id
    type             = "forward"
  }
}

