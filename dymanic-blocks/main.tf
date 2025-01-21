provider "aws" {
  region = "eu-central-1"
}

variable "http_ports" {
  type = list(string)
  default = [ "80","8080","443" ]
}

resource "aws_instance" "helloworld" {
  # Ubuntu ami
   ami           = "ami-023adaba598e661ac"
  # Debian ami
  #ami                    = "ami-042e6fdb154c830c5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.fw-rules.id, aws_security_group.web-rules.id]
  key_name               = aws_key_pair.helloworld-example.id
  tags = {
    Name   = "Hello World"
    Course = "TF Fundamentals"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_key_pair" "helloworld-example" {
  key_name   = "tf-ssh"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOphj6yDDPXIqbCxujSkRO6X0ZgCurVvnzULln47eqcY student@vincenzo-kmvc"
}

resource "aws_security_group" "fw-rules" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-rules" {
  name = "terraform-example-web"
  dynamic "ingress" {
    for_each = var.http_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "WEB" 
    }
  }
}
