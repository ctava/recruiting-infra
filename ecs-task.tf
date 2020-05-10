
data "template_file" "task" {
  template = file("./_templates/ecs-task-double-container.json.tpl")

  vars = {
    client_name              = var.client_name
    client_image             = var.client_image
    client_host_port         = var.client_port
    client_container_port    = var.client_port
    service_name             = var.service_name
    service_image            = var.service_image
    service_host_port        = var.service_port  
    service_container_port   = var.service_port 
    fargate_cpu              = var.fargate_half_cpu
    fargate_memory           = var.fargate_half_memory
    aws_region               = var.aws_region
    aws_vpc                  = var.aws_vpc
    log_driver               = var.log_driver
    log_prefix               = var.log_prefix
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.root_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.aws_vpc
  requires_compatibilities = [var.ecs_launch_type]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.task.rendered
}

resource "aws_ecs_service" "service" {
  name            = var.root_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = var.ecs_launch_type

  network_configuration {
    security_groups  = [aws_security_group.lb.id]
    subnets          = aws_subnet.public.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.id
    container_name   = var.client_name
    container_port   = var.client_port
  }

  depends_on = [aws_alb_listener.main, aws_iam_role_policy_attachment.ecs_task_execution_role, aws_security_group.ecs_task]
}

resource "aws_security_group" "ecs_task" {
  name        = var.ecs_task_security_group_name
  description = "provides access to task"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.client_port
    to_port         = var.client_port
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
