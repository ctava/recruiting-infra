[
  {
  "name": "${ui_name}",
  "image": "${ui_image}",
  "cpu": ${fargate_cpu},
  "memory": ${fargate_memory},
  "networkMode": "${aws_vpc}",
  "logConfiguration": {
      "logDriver": "${log_driver}",
      "options": {
        "awslogs-group": "/${log_prefix}/${ui_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${log_prefix}"
      }
  },
  "portMappings": [
    {
      "containerPort": ${ui_container_port},
      "hostPort": ${ui_host_port}
    }
  ]
  },
  {
  "name": "${service_name}",
  "image": "${service_image}",
  "cpu": ${fargate_cpu},
  "memory": ${fargate_memory},
  "networkMode": "${aws_vpc}",
  "logConfiguration": {
      "logDriver": "${log_driver}",
      "options": {
        "awslogs-group": "/${log_prefix}/${service_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${log_prefix}"
      }
  },
  "portMappings": [
    {
      "containerPort": ${service_container_port},
      "hostPort": ${service_container_port}
    }
  ]
  }
]
