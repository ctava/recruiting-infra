
resource "aws_alb" "main" {
  name            = var.lb_name
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "main" {
  name        = var.lb_target_group_name
  port        = var.http_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    port                = var.client_port
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

}

resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_alb.main.id
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.id
  }
}

resource "aws_security_group" "lb" {
  name        = var.lb_security_group_name
  description = "provides access to lb"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.http_port
    to_port     = var.client_port
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}