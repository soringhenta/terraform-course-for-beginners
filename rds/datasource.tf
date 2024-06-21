data "aws_ami" "ubuntu_lts" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/*/ubuntu*24.04-amd64-server-*"]
  }
}