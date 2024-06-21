resource "aws_security_group" "frontend" {
  name   = "Frontend${title(var.environment)}"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Frontend${title(var.environment)}"
  }
}

resource "aws_security_group_rule" "frontend_inbound_ssh_bastion" {
  type                     = "ingress"
  description              = "SSH From Bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "frontend_inbound_8080_elb" {
  type                     = "ingress"
  description              = "8080 From ELB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.elb.id
  security_group_id        = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "frontend_outbound_http_nat" {
  type                     = "egress"
  description              = "80 to NAT"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nat.id
  security_group_id        = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "frontend_outbound_https_nat" {
  type                     = "egress"
  description              = "443 to NAT"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nat.id
  security_group_id        = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "frontend_outbound_3306_backend" {
  type                     = "egress"
  description              = "3306 to Backend"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend.id
  security_group_id        = aws_security_group.frontend.id
}

resource "aws_security_group_rule" "frontend_outbound_all" {
  type              = "egress"
  description       = "Allow Frontend to All"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.frontend.id
}

resource "tls_private_key" "frontend" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "frontend" {
  key_name   = "Frontend${title(var.environment)}"
  public_key = tls_private_key.frontend.public_key_openssh
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.frontend_instance_type
  subnet_id     = aws_subnet.private_frontend.id
  key_name      = aws_key_pair.frontend.key_name
  # Waiting 60 seconds to allow NAT to be configured and then running a simple server to be able to test the solution
  user_data = <<EOF
    #! /bin/bash  
    sleep 60

    sudo yum update -y || true
    sudo yum install -y python3 || true
    sudo nohup python3 -m http.server 8080 > /var/log/server.log 2>&1 &
  EOF

  vpc_security_group_ids = [aws_security_group.frontend.id]

  tags = {
    Name = "FrontendHost${title(var.environment)}"
  }

  depends_on = [aws_instance.nat]
}
