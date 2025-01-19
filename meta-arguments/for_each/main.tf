provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  ami           = "ami-023adaba598e661ac"
  instance_type = "t2.micro"
  for_each = {
    "vm1" = {name = "machine1", zone = "eu-central-1a"}
    "vm2" = {name = "machine2", zone = "eu-central-1b"}
    "vm3" = {name = "machine3", zone = "eu-central-1c"}
  }
  availability_zone = each.value.zone
  tags = {
    Name = "HelloWorld-${each.value.name}"
  }
}