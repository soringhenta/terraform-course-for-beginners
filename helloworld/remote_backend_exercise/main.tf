
terraform {
  backend "s3" {
    
  }
}

module "ec2" {
  source = "./EC2"
  type = "t3.micro"
  ami = data.aws_ami.ubuntu.id
}

resource "random_string" "securitygroupname" {
  length  = 6
  special = false
  upper   = false
}

resource "tls_private_key" "sshkey" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "sshkey" {
  filename        = pathexpand("~/.ssh/${var.ssh_keyname}")
  content         = tls_private_key.sshkey.private_key_openssh
  file_permission = "0400"
}

resource "aws_key_pair" "name" {
  public_key = trimspace(tls_private_key.sshkey.public_key_openssh)
  key_name   = "sorin-key"
}

resource "aws_security_group" "incomingfw" {
  name = random_string.securitygroupname.result
  ingress {
    to_port     = var.ssh_port
    from_port   = var.ssh_port
    protocol    = "tcp"
    description = "Default SSH port"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_instance" "instance" {
#   instance_type = var.type
#   ami           = data.aws_ami.ubuntu.id
#   key_name = aws_key_pair.name.id
#   vpc_security_group_ids = [ aws_security_group.incomingfw.id ]
#   tags = {
#     name = "Sorin"
#     workspace = terraform.workspace
#   }
# }


