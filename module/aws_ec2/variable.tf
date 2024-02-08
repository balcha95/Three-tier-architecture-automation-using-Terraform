variable "web_ami" {
  description = "AMI of webservers"
  default     = "ami-0ce2cb35386fc22e9" # Change this value
}

variable "web_instance" {
  description = "Instance type of webservers"
  default     = "t2.micro"
}

variable "webserver_name" {
  description = "Name of web servers"
  default     = ["web1", "web2"]
}

variable "web_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in web layer"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "websg_name" {
  description = "Name of security group for webservers"
  default     = "webserver_sg"
}