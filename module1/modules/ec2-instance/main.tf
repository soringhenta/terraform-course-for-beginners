resource "aws_instance" "module-example" {
   ami = var.ec2-ami
   instance_type = "t2.micro"
   count = 1
   key_name = aws_key_pair.module-example.id
   vpc_security_group_ids = [aws_security_group.module-example.id]
   tags = {
   Name = "Hello World"
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