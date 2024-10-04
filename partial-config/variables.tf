resource "local_file" "hclconfig" {
    filename = "backend.hcl"
    content = <<EOT
    bucket = "${aws_s3_bucket.terraform_state.id}"
    dynamodb_table = "${aws_dynamodb_table.terraform_locks.id}"
    region = "${var.region}"
    encrypt = ${var.encrypt}
    EOT
}

variable "encrypt" {
    default = true
    type = bool
    description = "Enable/Disable backend encryption"
}

variable "region" {
    default = "eu-central-1"
    type = string
    description = "Default AWS Region"
}

variable "s3_bucket" {
    description = "S3 bucket used for remote backend"
    type = string
}

variable "dynamodb_table" {
    description = "DynamoDB table for remote backend"
    type = string
}