resource "local_file" "backend-partialconfig" {
  filename = "${path.module}/backend.hcl"
  content = <<EOT
  bucket = "${aws_s3_bucket.s3remote-sorin.bucket}"
  region = "${var.region}"
  encrypt = true
  key = "${var.statefilename}"
  EOT
  file_permission = "0600"
}

