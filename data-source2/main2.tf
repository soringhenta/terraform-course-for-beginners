provider "aws" {
    region = "eu-central-1"
}

data "aws_ami" "ubuntu" {

    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/*/ubuntu-*-24.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}

data "aws_key_pair" "ssh" {
  key_name           = "vdnp-key"
  include_public_key = true

  filter {
    name   = "tag:Use"
    values = ["test"]
  }
}

resource "aws_instance" "ubuntu_test" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ubuntu.id
    key_name                    = data.aws_key_pair.ssh.id
    vpc_security_group_ids      = [aws_security_group.ssh.id]
  
}

resource "aws_security_group" "ssh" {
  name = "ec2-group2"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu.id
}