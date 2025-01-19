provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
  ami           = "ami-023adaba598e661ac"
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "HelloWorld-${count.index}"
  }
}
