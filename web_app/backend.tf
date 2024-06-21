resource "aws_security_group" "backend" {
  name   = "Backend${title(var.environment)}"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Backend${title(var.environment)}"
  }
}

resource "aws_security_group_rule" "backend_inbound_ssh_bastion" {
  type                     = "ingress"
  description              = "SSH From Bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.backend.id
}

resource "aws_security_group_rule" "backend_inbound_3306_frontend" {
  type                     = "ingress"
  description              = "3306 From Frontend"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend.id
  security_group_id        = aws_security_group.backend.id
}

resource "aws_security_group_rule" "backend_outbound_http_nat" {
  type                     = "egress"
  description              = "80 To NAT"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nat.id
  security_group_id        = aws_security_group.backend.id
}

resource "aws_security_group_rule" "backend_outbound_https_nat" {
  type                     = "egress"
  description              = "443 To NAT"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nat.id
  security_group_id        = aws_security_group.backend.id
}

resource "aws_security_group_rule" "backend_outbound_all" {
  type              = "egress"
  description       = "Allow Backend to All"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend.id
}

# Using RDS would require more than 1 AZ, which is not covered by the current requirement. Therefore, using EC2
resource "tls_private_key" "backend" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "backend" {
  key_name   = "Backend${title(var.environment)}"
  public_key = tls_private_key.backend.public_key_openssh
}

resource "aws_instance" "backend" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.backend_instance_type
  subnet_id     = aws_subnet.private_backend.id
  key_name      = aws_key_pair.backend.key_name
  # Waiting 60 seconds to allow NAT to be configured and then a mock of the DB configuration. In a real world we would either use RDS or a real script
  user_data = <<EOF
    #! /bin/bash
    sleep 60

    echo "Script to install MySQL DB goes here. The script will use encrypted value of '${var.database_master_password}'"
    sudo yum update -y || true
    sudo yum install -y python3 || true
    sudo nohup python3 -m http.server 3306 > /var/log/server.log 2>&1 &
  EOF

  vpc_security_group_ids = [aws_security_group.backend.id]

  tags = {
    Name = "Backend${title(var.environment)}"
  }

  depends_on = [aws_instance.nat]
}
