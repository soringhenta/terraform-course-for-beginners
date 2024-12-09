provider "aws" {
  region = "eu-central-1"
}

locals {
  # Ubuntu
  #ami = "ami-023adaba598e661ac"
  # Debian
  ami = "ami-042e6fdb154c830c5"
  instance_type = "t2.micro"
  count         = 1
}

resource "aws_instance" "helloworld" {
  ami                    = local.ami
  instance_type          = local.instance_type
  count                  = local.count
  vpc_security_group_ids = [aws_security_group.helloworld.id]
  tags = {
    Name = "Hello World"
  }
}

resource "aws_security_group" "helloworld" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
