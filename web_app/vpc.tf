resource "aws_vpc" "this" {
  cidr_block           = var.main_vpc_cidr_block
  instance_tenancy     = var.main_vpc_instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MainVPC${title(var.environment)}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "MainIGW${title(var.environment)}"
  }

  depends_on = [aws_vpc.this]
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet.cidr
  availability_zone       = var.public_subnet.az
  map_public_ip_on_launch = true

  tags = {
    Name       = "PublicSubnet${title(var.environment)}"
    subnetType = "public"
  }

  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

resource "aws_subnet" "private_frontend" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.frontend_subnet.cidr
  availability_zone = var.frontend_subnet.az

  tags = {
    Name       = "PrivateSubnetFrontend${title(var.environment)}"
    subnetType = "private"
  }

  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

resource "aws_subnet" "private_backend" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.backend_subnet.cidr
  availability_zone = var.backend_subnet.az

  tags = {
    Name       = "PrivateSubnetBackend${title(var.environment)}"
    subnetType = "private"
  }

  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "PublicRouteTable${title(var.environment)}"
  }

  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.this,
    aws_subnet.public
  ]
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

  depends_on = [aws_route_table.public]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "PrivateRouteTable${title(var.environment)}"
  }

  depends_on = [aws_vpc.this]
}

resource "aws_route_table_association" "private_frontend" {
  subnet_id      = aws_subnet.private_frontend.id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route_table.private]
}

resource "aws_route_table_association" "private_backend" {
  subnet_id      = aws_subnet.private_backend.id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route_table.private]
}
