resource "aws_security_group" "nat" {
  name   = "NAT${title(var.environment)}"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "NAT${title(var.environment)}"
  }
}

resource "aws_security_group_rule" "nat_inbound_ssh_bastion" {
  type                     = "ingress"
  description              = "SSH From Bastion"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion.id
  security_group_id        = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat_inbound_http_frontend" {
  type                     = "ingress"
  description              = "Allow inbound http traffic from the frontend subnet"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend.id
  security_group_id        = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat_inbound_http_backend" {
  type                     = "ingress"
  description              = "Allow inbound http traffic from the backend subnet"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend.id
  security_group_id        = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat_inbound_https_frontend" {
  type                     = "ingress"
  description              = "Allow inbound https traffic from the frontend subnet"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend.id
  security_group_id        = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat_inbound_https_backend" {
  type                     = "ingress"
  description              = "Allow inbound https traffic from the backend subnet"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend.id
  security_group_id        = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat_outbound_all" {
  type              = "egress"
  description       = "Allow outbound to All"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat.id
}

resource "tls_private_key" "nat" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nat" {
  key_name   = "NAT${title(var.environment)}"
  public_key = tls_private_key.nat.public_key_openssh
}

resource "aws_instance" "nat" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.nat_instance_type
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.nat.key_name

  # https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#create-nat-ami
  user_data = <<EOF
    #! /bin/bash 
    sudo yum install iptables-services -y
    sudo systemctl enable iptables
    sudo systemctl start iptables
    sudo echo "net.ipv4.ip_forward=1" > /etc/sysctl.d/custom-ip-forwarding.conf
    sudo sysctl -p /etc/sysctl.d/custom-ip-forwarding.conf

    sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    sudo /sbin/iptables -F FORWARD
    sudo service iptables save
  EOF

  vpc_security_group_ids = [aws_security_group.nat.id]
  source_dest_check      = false

  tags = {
    Name = "NATInstance${title(var.environment)}"
  }
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_instance.nat.primary_network_interface_id

  depends_on = [aws_route_table.private]
}
