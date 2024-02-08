# Create EC2 instances for webservers

resource "aws_instance" "webservers" {
  count           = length(var.web_subnets_cidr_blocks)
  ami             = var.web_ami
  instance_type   = var.web_instance
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  subnet_id       = element(aws_subnet.web.*.id, count.index)

  tags = {
    Name = element(var.webserver_name, count.index)
  }
}

# Create security group for webservers

resource "aws_security_group" "webserver_sg" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.websg_name
  }
}
