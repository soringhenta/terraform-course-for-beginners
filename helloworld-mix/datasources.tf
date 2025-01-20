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

data "aws_ec2_instance_type_offering" "valid_instance_type" {
  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }
}
