provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "helloworld" {
  ami = var.aws_ami # Ubuntu
  # ami = "ami-042e6fdb154c830c5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.infocomingfw.id]
  key_name               = aws_key_pair.tfcourse.id
  tags = {
    Name = "HelloWorld-Sorin"
  }
}

resource "aws_security_group" "infocomingfw" {
  name = "terraform-example-instance-sorin"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "tfcourse" {
  key_name   = "ssh-sorin"
  public_key = var.ssh_key
}
