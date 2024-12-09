provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  ami                    = var.default_ami
  instance_type          = var.default_itype
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "Hello World"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}