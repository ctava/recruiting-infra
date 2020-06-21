resource "aws_ecr_repository" "ui-repo" {
  name = var.ui_name
}

resource "aws_ecr_repository" "service-repo" {
  name = var.service_name
}
