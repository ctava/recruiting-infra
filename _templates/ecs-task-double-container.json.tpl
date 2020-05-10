[
  {
  "name": "${client_name}",
  "image": "${client_image}",
  "cpu": ${fargate_cpu},
  "memory": ${fargate_memory},
  "networkMode": "${aws_vpc}",
  "logConfiguration": {
      "logDriver": "${log_driver}",
      "options": {
        "awslogs-group": "/${log_prefix}/${client_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${log_prefix}"
      }
  },
  "portMappings": [
    {
      "containerPort": ${client_container_port},
      "hostPort": ${client_host_port}
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
