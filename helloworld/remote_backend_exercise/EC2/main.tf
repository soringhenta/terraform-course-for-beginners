
variable "ami" {
  description = "EC2 input AMI"
  default = ""
}

variable "type" {
  description = "EC2 instance type"
  default = ""
}

resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.type
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

