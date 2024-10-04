locals {
   type = "t2.micro"
   os   = "ami-023adaba598e661ac"
 }

resource "aws_instance" "varexample" {
  instance_type = var.type
  ami           = var.os
  tags = {
    Name = "Var Example"
  }
}
