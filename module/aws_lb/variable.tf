variable "lb_name" {
  description = "Name of the application load balancer"
  default     = "applb"
}

variable "tg_name" {
  description = "Name of the application load balancer target group"
  default     = "applb-tg"
}

variable "tg_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "80"
}

variable "tg_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTP"
}

variable "listener_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "443"
}

variable "listener_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTPS"
}

# Certificate ARN for HTTPS
variable "certificate_arn_user" {
  description = "Enter the certificate ARN for HTTPS"
  default     = "arn:aws:acm:us-west-1:750740692701:certificate/d5b9610f-1966-4891-843b-4dd8eda4a80c" # Change this value 
}
