variable "tcp_ports" {
  type    = list(object({ from = number, to = number }))
  default = [
    { from = 5060, to = 5061 },
    { from = 22, to = 22 },
    { from = 80, to = 80 },
    { from = 443, to = 443 },
  ]
}

variable "udp_ports" {
  type    = list(object({ from = number, to = number }))
  default = [
    { from = 10000, to = 32768 },
    { from = 5060, to = 5061 },
  ]
}

resource "aws_security_group" "voip" {
  name        = "voip-fwrules"
  description = "Security group with TCP and UDP rules"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  dynamic "ingress" {
    for_each = var.tcp_ports
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.udp_ports
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}
