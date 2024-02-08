# Create RDS subnet group

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_name
 subnet_ids = toset(aws_subnet.db.*.id)
  tags = {
    Name = var.rds_subnet_name
  }
}

# Create RDS instance 

resource "aws_db_instance" "rds" {
  allocated_storage    = var.rds_storage
  engine               = var.rds_engine
  instance_class       = var.rds_instance_class
  username             = var.rds_username
  password             = var.rds_password
  db_subnet_group_name = var.rds_subnet_name
  depends_on           = [aws_db_subnet_group.rds_subnet_group]
}

# Create Route tables for App layer

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.default.id
  }

  tags = {
    Name = "DB"
  }
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnets_cidr_blocks)
  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = aws_route_table.db.id
}
