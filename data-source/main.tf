provider "aws" {
    region = "eu-central-1"
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

resource "aws_instance" "ubuntu_test" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ubuntu.id
  
}

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu.id
}