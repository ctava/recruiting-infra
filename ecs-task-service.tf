data "template_file" "service" {
  template = file("./_templates/ecs-task-container.json.tpl")

  vars = {
    app_name                 = var.service_name
    app_image                = var.service_image
    app_port                 = var.service_port
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_region               = var.aws_region
    aws_vpc                  = var.aws_vpc
    log_driver               = var.log_driver
    log_prefix               = var.log_prefix
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = var.service_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.service.rendered
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.service_ecs_task.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.service.id
    container_name   = var.service_name
    container_port   = var.service_port
  }

  depends_on = [aws_alb_listener.service, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

