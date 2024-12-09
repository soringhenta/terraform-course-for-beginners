provider "aws" {
   region = "eu-central-1"
}

module "ami-data" {
  source = "./modules/ec2-instance"
  ec2-ami = "ami-023adaba598e661ac"
}
