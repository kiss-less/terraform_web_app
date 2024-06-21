resource "aws_security_group" "bastion" {
  name   = "Bastion${title(var.environment)}"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Bastion${title(var.environment)}"
  }
}

resource "aws_security_group_rule" "bastion_inbound_ssh" {
  type              = "ingress"
  description       = "SSH From Specified CIDR"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ssh_cidrs_list
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_outbound_frontend_ssh" {
  type                     = "egress"
  description              = "Allow SSH to the Frontend SG"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend.id
  security_group_id        = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_outbound_backend_ssh" {
  type                     = "egress"
  description              = "Allow SSH to the Backend SG"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend.id
  security_group_id        = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_outbound_nat_ssh" {
  type                     = "egress"
  description              = "Allow SSH to the NAT SG"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nat.id
  security_group_id        = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_outbound_all" {
  type              = "egress"
  description       = "Allow Bastion to All"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}

resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "Bastion${title(var.environment)}"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.bastion_instance_type
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion.key_name

  vpc_security_group_ids = [aws_security_group.bastion.id]

  tags = {
    Name = "BastionHost${title(var.environment)}"
  }
}
