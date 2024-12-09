provider "aws" {
    region = "eu-central-1"
}

module "ami-data" {
   source = "./modules/aws/ec2-instance"
   ec2-ami = module.data-source.ubuntu.id
}

module "data-source" {
    source = "./modules/data-source"
}