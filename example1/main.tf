provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example1" {
  ami                    = "ami-023adaba598e661ac"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = aws_key_pair.sshkey.id
  tags = {
    Name   = "TF-Example"
    Course = "TF Fundamentals"
  }
}

resource "aws_security_group" "ssh" {
  name = "ssh-ingress"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "sshkey" {
  key_name   = "vdnp-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEnBkuasXvZ/v/Ldf5dXZSjPmN0x3gO1Ub75naPESXaz student@vincenzo-cjm5"
  lifecycle {
    prevent_destroy = false
  }
}
