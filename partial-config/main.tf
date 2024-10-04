#terraform {
# backend "s3" {
#   key = "test/terraform.tfstate"
# }
#}

provider "aws" {
    region = "${var.region}"
}
