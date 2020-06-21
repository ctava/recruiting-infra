data "template_file" "recruiting" {
  template = file("./_templates/ecs-task-double-container.json.tpl")

  vars = {
    ui_name                  = var.ui_name
    ui_image                 = var.ui_image
    ui_host_port             = var.ui_port
    ui_container_port        = var.ui_port
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

resource "aws_ecs_task_definition" "recruiting" {
  family                   = var.root_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.recruiting.rendered
}

resource "aws_ecs_service" "recruiting" {
  name            = var.root_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.recruiting.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = var.ui_name
    container_port   = var.ui_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

