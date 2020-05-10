resource "aws_ecr_repository" "client-repo" {
  name = var.client_name
}

resource "aws_ecr_repository" "service-repo" {
  name = var.service_name
}
