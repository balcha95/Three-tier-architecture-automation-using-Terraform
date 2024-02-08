# service/main.tf

# Data source to retrieve available availability zones
data "aws_availability_zones" "available" {}

# Create default VPC
resource "aws_vpc" "default" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Create subnets for web layer
resource "aws_subnet" "web" {
  count             = length(var.web_subnets_cidr_blocks)
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.web_subnets_cidr_blocks[count.index]

  tags = {
    Name = "web-public-${count.index}"
  }
}

# Create subnets for app layer
resource "aws_subnet" "app" {
  count             = length(var.app_subnets_cidr_blocks)
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.app_subnets_cidr_blocks[count.index]

  tags = {
    Name = "app-private-${count.index}"
  }
}

# Create subnets for DB layer
resource "aws_subnet" "db" {
  count             = length(var.db_subnets_cidr_blocks)
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.db_subnets_cidr_blocks[count.index]

  tags = {
    Name = "db-private-${count.index}"
  }
}

# Create an internet gateway to provide access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = var.vpc_name
  }
}

# Create public subnet for common resources like NAT Gateway etc.
resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidr_blocks)
  vpc_id            = aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.public_subnets_cidr_blocks[count.index]

  tags = {
    Name = "public-${count.index}"
  }
}

# Create route tables for web layer
resource "aws_route_table" "web" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Web"
  }
}
