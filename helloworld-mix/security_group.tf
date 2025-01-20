locals {
  ssh_port = 22
}

resource "aws_security_group" "inbound_rules" {
  name = "Inboung Rules"
  ingress {
    protocol    = "tcp"
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    description = "SSH Default Port"
    cidr_blocks = ["95.50.196.86/32"]
  }
}

resource "aws_key_pair" "vincenzo_ssh" {
  key_name   = "vincenzo-key"
  public_key = var.ssh_key
}