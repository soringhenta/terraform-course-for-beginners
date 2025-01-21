provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  # ami           = "ami-023adaba598e661ac" # Ubuntu
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.vincenzo_ssh.id
  vpc_security_group_ids = ["${aws_security_group.inbound_rules.id}"]
  instance_type          = var.instance_type
  depends_on = [ data.aws_ec2_instance_type_offering.valid_instance_type ]
  tags = {
    Name = "HelloWorld vincenzo"
  }
  lifecycle {
    create_before_destroy = true
  }
}

output "instance_type_exists" {
  value = length(data.aws_ec2_instance_type_offering.valid_instance_type) > 0
}
