# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket = "vincenzo-uigppnen"
#     # Key MUST be unique
#     key = "global/s3/terraform.tfstate"
#     region = "eu-central-1"
#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "vincenzo-uigppnen"
#     encrypt = true
#   }
# }

provider "aws" {
  region = "eu-central-1"
}

variable "environment" {
  default = "dev"
}

resource "aws_instance" "helloworld" {
  ami           = "ami-023adaba598e661ac"
  for_each = {
    "vm1" = {name = "machine1", zone = "eu-central-1a"}
    "vm2" = {name = "machine2", zone = "eu-central-1b"}
    "vm3" = {name = "machine3", zone = "eu-central-1c"}
  }
  instance_type = "${var.environment == "prod" ? "t2.micro" : "t3.micro"}"
  availability_zone = each.value.zone
  tags = {
    Name = "HelloWorld-${each.value.name}"
  }
}

resource "aws_ec2_instance_state" "test" {
  for_each = aws_instance.helloworld
  instance_id = aws_instance.helloworld[each.key].id
  state = ( data.aws_instance.status[each.key].instance_state == "stopped" ? "running" : "running")
}

data "aws_instance" "status" {
  for_each = aws_instance.helloworld
  instance_id = aws_instance.helloworld[each.key].id
}

output "instance_state" {
  value = { for i in aws_instance.helloworld: i.id => "${i.instance_state}" }
  depends_on = [ data.aws_instance.status ]
}


