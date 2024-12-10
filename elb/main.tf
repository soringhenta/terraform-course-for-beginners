provider "aws" {
  region = "eu-central-1"
}

variable "vpc_name" {
    type = string
    default = "myvpc"
}

variable "vpc_cidr_block" {
    type = string
    default = "10.10.0.0/16"
}

variable "web_subnet" {
  type = object({
    name = list(string)
    cidr = list(string) 
  })
  default = {
    name = [ "subnet1","subnet2","subnet3" ]
    cidr = [ ]
    az = [ ]
    }
}

locals {
  generated_cidr = cidrsubnets("${var.vpc_cidr_block}", 8, 8, 8)
}

locals {
  az = data.aws_availability_zones.available.names
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_route_table_association" "subnet_association" {
  for_each = aws_subnet.web

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "web" {
  for_each = { for i, name in var.web_subnet.name : name => {
    cidr = local.generated_cidr[i]
    az   = local.az[i]}
  }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone = each.value.az
  cidr_block = each.value.cidr
  tags = {
    Name = each.key
  }
}

resource "aws_lb" "alb" {
  name               = "alb-high-avail"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = values(aws_subnet.web)[*].id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  for_each = {
    for i, instance in aws_instance.lb_instance : i => instance
  }
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = each.value.id
  port             = 80
}

data "aws_ami" "ubuntu_lts" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/*/ubuntu*24.04-amd64-server-*"]
  }
}

resource "aws_instance" "lb_instance" {
  ami                         = data.aws_ami.ubuntu_lts.id
  for_each = aws_subnet.web
  subnet_id      = each.value.id
  # count = 3
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.internal.id,aws_security_group.ssh.id]
  # key_name                    = aws_key_pair.tf_keypair.id
  associate_public_ip_address = true
  user_data_replace_on_change = true
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y apache2 mysql-client
                sudo a2enmod ssl
                sudo a2ensite default-ssl.conf
                sudo systemctl reload apache2
                sudo systemctl start apache2
                echo "My IP is $(curl -s ifconfig.me)" |sudo tee /var/www/html/index.html >/dev/null
                EOF
  tags = {
    Name = var.vpc_name
  }
  # depends_on = [ aws_subnet.web ]
}

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

resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal" {
  name = "internal_web"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
    # cidr_blocks = [aws_lb.alb.]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    security_groups = [aws_security_group.alb_security_group.id]
  }
}

output "az" {
  value = data.aws_availability_zones.available.names
}

output "dns" {
 value = aws_lb.alb.dns_name 
}