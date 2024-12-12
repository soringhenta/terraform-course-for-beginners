terraform {
  backend "s3" {
    key = "exercise/terraform.tfstate"
  }
}

provider "aws" {
  region = var.awsregion
}

module "remote-backend" {
  source = "./remote-backend"
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"
}


module "partial-config" {
  source = "./partial-config"
  s3bucket = module.s3-bucket.s3_bucket_id
  # s3bucket = module.remote-backend.bucketname.id
  dynamotable = module.remote-backend.dynamodb_table.id
}

module "ssh-key" {
    source = "./ssh-key"  
}

module "ec2_instances" {
    source = "./ec2"
    ssh_key = module.ssh-key.mynewkey
    securitygroups = module.securitygroups.securitygroups
}

module "securitygroups" {
  source = "./security-groups"
}