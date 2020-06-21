### Provider

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "access_key" {
  description = "The AWS access key"
  default     = "<redacted>"
}

variable "secret_key" {
  description = "The AWS secret key"
  default     = "<redacted>"
}

variable "deployer_key_name" {
  description = "key id"
  default = "ec2-bastion"
}

variable "deployer_public_key" {
  type = "string"
  default = <<EOF
<redacted>
EOF
}

### Global Names

variable "root_name" {
  description = "root system name"
  default     = "recruiting"
}

variable "ui_name" {
  description = "name of client app"
  default     = "recruiting-ui"
}

variable "service_name" {
  description = "name of server app"
  default     = "recruiting-service"
}

### Logging

variable "ui_log_group" {
  description = "name of ui log group"
  default     = "/ecs/recruiting-ui"
}

variable "service_log_group" {
  description = "name of service log group"
  default     = "/ecs/recruiting-service"
}

variable "retention_in_days" {
  description = "log retention in days"
  default     = "30"
}

variable "log_prefix" {
  description = "log group or stream prefix"
  default     = "ecs"
}

variable "log_driver" {
  description = "log driver"
  default     = "awslogs"
}

variable "lb_access_logs_s3_bucket" {
  description = "s3 bucket"
  default     = "recruiting-access-logs-2"
}

### Networking

variable "aws_vpc" {
  description = "virtual private center"
  default     = "awsvpc"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "http_port" {
  description = "Http Port"
  default     = 80
}

variable "ssh_port" {
  description = "ssh port"
  default     = 22
}

variable "public_cidr_block" {
  description = "cidr block"
  default     = "0.0.0.0/0"
}

variable "private_cidr_block" {
  description = "cidr block"
  default     = "172.17.0.0/16"
}

variable "lb_name" {
  description = "name of the load balancer"
  default = "recruiting-lb"
}

variable "lb_target_group_name" {
  description = "name of the lb target group"
  default = "recruiting-lb-target-group"
}

variable "lb_security_group_name" {
  description = "name of the lb security group"
  default = "recruiting-lb-security-group"
}

### ECS / Fargate

variable "ecs_launch_type" {
  description = "capability / type of ECS launch"
  default     = "FARGATE"
}

variable "ecs_cluster_name" {
  description = "name of ecs cluster"
  default     = "recruiting"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "recruiting-ecs-task-execution-role"
}

variable "disabled_desired_count" {
  description = "Number of docker instances to run"
  default     = 0
}

variable "desired_count" {
  description = "Number of docker instances to run"
  default     = 1
}

variable "container_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "fargate_half_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_half_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

variable "ui_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "<redacted>.dkr.ecr.us-east-1.amazonaws.com/recruiting-ui:latest"
}

variable "ui_port" {
  description = "Port exposed by the docker image"
  default     = 3000
}

variable "service_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "<redacted>.dkr.ecr.us-east-1.amazonaws.com/recruiting-service:latest"
}

variable "service_port" {
  description = "Port exposed by the docker image"
  default     = 2999
}

variable "ecs_task_security_group_name" {
  description = "name of ecs task security group"
  default     = "recruiting-ecs-task-security-group"
}

variable "task_count" {
  description = "Number of ecs tasks to run"
  default     = 1
}

### Autoscaling

variable "ecs_scale_up" {
  description = "Scale up"
  default     = "ecs_scale_up"
}

variable "ecs_scale_down" {
  description = "Scale down"
  default     = "ecs_scale_down"
}

variable "ecs_cpu_utilization_high" {
  description = "CPU high"
  default     = "ecs_cpu_high"
}

variable "ecs_cpu_utilization_low" {
  description = "CPU low"
  default     = "ecs_cpu_low"
}


### RDS

variable "rds_identifier" {
  description = "Defines the RDS cluster identifier"
  default = "recruiting"
}

variable "rds_family" {
  description = "Defines the RDS family"
  default = "postgres"
}

variable "rds_type" {
  description = "Defines the RDS type"
  default = "postgresql"
}

variable "rds_engine" {
  description = "Defines the RDS engine type"
  default = "postgres"
}

variable "rds_engine_version" {
  description = "Engine version"
  default     = "9.6"
}

variable "rds_username" {
  description = "Defines the username which has completely control on the db"
  default = "recruiting"
}
variable "rds_password" {
  description = "Defines the password which has complete control on the db"
  default = "<redacted>"
}

variable "rds_allocated_storage" {
  default     = "20"
  description = "The storage size in GB"
}

variable "rds_multi_az" {
  default     = false
  description = "Muti-az allowed?"
}

variable "rds_preferred_maintenance_window" {
  description = "When AWS can run snapshot, can't overlap with maintenance window"
  default     = "sun:03:55-sun:04:25"
}

variable "rds_preferred_backup_window" {
  description = "When AWS can run snapshot, can't overlap with maintenance window"
  default     = "02:00-03:00"
}

variable "rds_backup_retention_period" {
  description = "The number in days maintained for snapshot history"
  default     = 7
}

variable "rds_instance_count" {
  description = "Defines the number of instances to be placed in the cluster"
  default = 1
}

variable "rds_instance_class" {
  description = "Defines the db instance type"
  default     = "db.t2.small"
}

variable "rds_publically_accessible" {
  description = "Determins if the db is publically accessible"
  default     = "false"
}

variable "rds_port" {
  description = "Port to connet to the database"
  default     = 5432
}

variable "rds_kms_key_arn" {
  description = "ARN to allow access to all principals"
  default     = "<redacted>"
}

variable "rds_security_group_name" {
  description = "name of rds security group"
  default     = "recruiting-rds-security-group"
}

### EC2 Bastion

variable "bastion_ami_image_id" {
  description = "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in us-east-1"
  default = "ami-085925f297f89fce1"
}

variable "bastion_instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
variable "bastion_cidr_block" {
  description = "cidr block for private access"
  default     = "0.0.0.0/0"
}

variable "bastion_security_group_name" {
  description = "name of bastion security group"
  default     = "recruiting-bastion-security-group"
}