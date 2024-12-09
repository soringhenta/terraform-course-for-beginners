provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  ami                    = "ami-042e6fdb154c830c5"
  vpc_security_group_ids = [aws_security_group.instance.id]
  for_each               = toset(var.ec2_tag)
  instance_type          = var.ec2_instance_type
  tags = {
    Name = each.value
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
