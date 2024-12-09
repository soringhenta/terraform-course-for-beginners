provider "aws" {
    region = var.aws-region
}

provider "google" {
  project = var.gcp-project_id
  region  = var.gcp-region
  zone = var.gcp-zone
}

module "ec2-instances" {
   source = "./modules/aws/ec2"
}

module "gcp-instances" {
   source = "./modules/gcp/gcp-instance"
}

