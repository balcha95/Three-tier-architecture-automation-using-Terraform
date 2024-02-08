# service/main.tf

# Create RDS subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = var.rds_subnet_name
  subnet_ids  = toset(aws_subnet.db.*.id)
  
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
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  
  depends_on = [aws_db_subnet_group.rds_subnet_group]
}

# Create Route tables for DB layer
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

# Variables
variable "db_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in DB layer"
  default     = ["10.0.6.0/24", "10.0.8.0/24"]
}

variable "rds_subnet_name" {
  description = "Name of the RDS subnet group"
  default     = "rds_group"
}

variable "rds_storage" {
  description = "RDS storage space"
  default     = "10"
}

variable "rds_engine" {
  description = "RDS engine type"
  default     = "mysql"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  default     = "db.t2.micro"
}

variable "rds_username" {
  description = "Username of the RDS"
  default     = "mysql_terraform"
}

variable "rds_password" {
  description = "Password of the RDS"
  default     = "terraformrds"
}
