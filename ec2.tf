resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami_image_id
  instance_type          = var.bastion_instance_type
  subnet_id              = aws_subnet.public[1].id
  vpc_security_group_ids = [aws_security_group.bastion.id,aws_security_group.rds.id]
  key_name               = var.deployer_key_name
}

resource "aws_security_group" "bastion" {
  name                  = var.bastion_security_group_name
  description           = "provides access to bastion"
  vpc_id                = aws_vpc.main.id

  # Inbound ssh
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.bastion_cidr_block]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.deployer_key_name
  public_key = var.deployer_public_key
}