provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  # Ubuntu ami
  # ami           = "ami-023adaba598e661ac"
  # Debian ami
  ami                    = "ami-042e6fdb154c830c5"
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
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }
}

resource "aws_security_group" "web-rules" {
  name = "terraform-example-web"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "WEB"
  }
}
