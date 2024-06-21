resource "aws_security_group" "elb" {
  name   = "ELB${title(var.environment)}"
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "ELB${title(var.environment)}"
  }
}

resource "aws_security_group_rule" "elb_inbound_http_all" {
  type              = "ingress"
  description       = "Allow 80 from All"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb_inbound_https_all" {
  type              = "ingress"
  description       = "Allow 443 from All"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb.id
}

resource "aws_security_group_rule" "elb_outbound_8080_frontend" {
  type                     = "egress"
  description              = "Allow 8080 to Frontend"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend.id
  security_group_id        = aws_security_group.elb.id
}

resource "aws_elb" "elb" {
  name            = "ELB${title(var.environment)}"
  internal        = false
  subnets         = [aws_subnet.public.id, aws_subnet.private_frontend.id, aws_subnet.private_backend.id]
  security_groups = [aws_security_group.elb.id]
  instances       = [aws_instance.frontend.id]

  # The https listener won't work without an SSL certificate, which requires a route53 hosting zone, domain and DNS records
  # For the simplicity reason I'm going to additionally add an HTTP listener that can be used to test the solution
  listener {
    instance_port     = 8080
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  tags = {
    Name = "ELB${title(var.environment)}"
  }
}
