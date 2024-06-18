provider "aws" {
  region = "eu-central-1"
}

variable "vpc-name" {
    type = string
}

variable "vpc-cidr-block" {
    type = string
}

variable "list_example" {
    description = "An example of a list in Terraform"
    type = list
    # default = ["a", "b", "c"]
    default = ["a", "b"]
    validation {
      condition = length(var.list_example) > 3
      error_message = "Too few elements"
    }
}


resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
    Name = var.vpc-name
  }
}

# resource "aws_lb" "alb" {
#   name               = "alb-high-avail"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_security_group.id]
#   subnets            = [aws_subnet.web-subnet1.id,aws_subnet.web-subnet2.id]
# }

resource "aws_security_group" "alb_security_group" {
  name        = "alb-sg"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP from Internet"
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
    Name = "alb-sg"
  }
}