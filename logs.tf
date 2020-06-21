
resource "aws_cloudwatch_log_group" "ui_log_group" {
  name              = var.ui_log_group
  retention_in_days = var.retention_in_days

  tags = {
    Name = var.ui_log_group
  }
}

resource "aws_cloudwatch_log_group" "service_log_group" {
  name              = var.service_log_group
  retention_in_days = var.retention_in_days

  tags = {
    Name = var.service_log_group
  }
}
