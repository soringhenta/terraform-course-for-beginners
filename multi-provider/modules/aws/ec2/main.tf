locals {
    count = 1
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}

resource "aws_instance" "awslab" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    count = local.count
    key_name = aws_key_pair.deployer.id
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data_replace_on_change = true
    user_data = <<-EOF
                #!/bin/bash
                sudo apt install -y apache2
                sudo systemctl start apache2
                EOF
    tags = {
	    Name = "Multi Cloud EC2"
  }
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance.id
# source_security_group_id = aws_security_group.instance.id
}

resource "aws_security_group" "instance" {
	name = "ec2-group2"
	ingress {
		from_port = var.ssh_port
		to_port = var.ssh_port
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2-keypair2"
  public_key = var.ssh_key
}
