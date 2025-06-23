terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "helloworld-state"
    # Key MUST be unique
    key = "global/s3/terraform.tfstate"
    region = "eu-central-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "helloworld-locks"
    encrypt = true
  }
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "helloworld" {
    ami = "ami-023adaba598e661ac"
    instance_type = "t2.micro"
    tags = {
        Name = "HelloWorld"
    }
}