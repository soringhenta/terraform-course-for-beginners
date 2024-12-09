resource "aws_instance" "module-example" {
    ami = var.ec2-ami
    key_name = aws_key_pair.module-example.id
    vpc_security_group_ids = [aws_security_group.module-example.id]
    for_each = toset(var.ec2-tag)
   	instance_type = var.ec2-instance-type
    tags = {
	    Name = each.value
  }
}

resource "aws_security_group" "module-example" {
	name = "terraform-module-example-instance"
	ingress {
		from_port = var.ssh_port
		to_port = var.ssh_port
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_key_pair" "module-example" {
  key_name   = "module-deployer-key"
  public_key = var.ssh_key
}
