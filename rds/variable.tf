variable "aws_region" {
  description = "Default AWS Region"
}

variable "instance_type" {
  description = "Default EC2 instance type"
  type        = string
  validation {
    condition     = var.instance_type == "t2.micro"
    error_message = "t2.micro only allowed"
  }
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
}

variable "ssh_port" {
  description = "Default ssh port"
  type        = number
}

variable "http_port" {
  description = "Defautl HTTP/HTTPS ports"
  type        = number
}

variable "https_port" {
  description = "Defautl HTTP/HTTPS ports"
  type        = number
}

variable "mysql_port" {
  description = "Default MySQL port"
  type        = number
}

variable "db_instance_class" {
  description = "Default DB Instance"
  type        = string
}

variable "db_username" {
  description = "Default DB User"
  type        = string
}

variable "db_instance_name" {
  description = "Default DB Instance Name"
  type        = string
}