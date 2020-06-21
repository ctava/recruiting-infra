[
  {
    "name": "${app_name}",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "${aws_vpc}",
    "logConfiguration": {
        "logDriver": "${log_driver}",
        "options": {
        "awslogs-group": "/${log_prefix}/${app_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${log_prefix}"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]
