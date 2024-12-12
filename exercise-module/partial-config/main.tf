resource "local_file" "name" {
    filename = "remote.hcl"
    content = <<EOF
    bucket = "${var.s3bucket}"
    region = "${var.awsregion}"
    dynamodb_table = "${var.dynamotable}"
    encrypt = true
    EOF
}