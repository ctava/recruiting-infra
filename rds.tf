resource "aws_db_instance" "default" {
  identifier                      = var.rds_identifier
  engine                          = var.rds_engine
  engine_version                  = var.rds_engine_version
  instance_class                  = var.rds_instance_class
  allocated_storage               = var.rds_allocated_storage
  multi_az                        = var.rds_multi_az
  final_snapshot_identifier       = "${var.rds_identifier}-final"
  skip_final_snapshot             = true
  apply_immediately               = true
  backup_retention_period         = var.rds_backup_retention_period
  username                        = var.rds_username
  password                        = var.rds_password
  enabled_cloudwatch_logs_exports = ["${var.rds_type}"]

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.rds_identifier

  kms_key_id        = var.rds_kms_key_arn
  storage_encrypted = true

  lifecycle {
    ignore_changes = ["password", "engine_version"]
  }

  depends_on = [aws_db_subnet_group.default]

}

resource "aws_db_subnet_group" "default" {
  name        = var.rds_identifier
  description = "Allowed subnets for db instances"
  subnet_ids  = aws_subnet.private.*.id
}

resource "aws_security_group" "rds" {
  name        = var.rds_security_group_name
  description = "provides access to rds"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol        = "tcp"
    from_port       = var.rds_port
    to_port         = var.rds_port
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
