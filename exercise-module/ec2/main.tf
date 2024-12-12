resource "aws_instance" "ec2_instances" {
  ami = data.aws_ami.ubuntu.id
  key_name = var.ssh_key
  vpc_security_group_ids = [ var.securitygroups ]
  for_each               = toset(var.ec2-tag)
  instance_type          = var.ec2-instance-type
  tags = {
    Name = each.value
  }
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