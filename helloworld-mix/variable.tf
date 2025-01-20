variable "instance_type" {
  description = "Default EC2 Instance type"
#   default     = "t2.micro"
#   validation {
#     condition     = "${var.instance_type}" == "t2.micro" || "${var.instance_type}" == "t3.micro"
#     error_message = "Instance type not allowed"
#   }
}

variable "defaul_ami" {
  description = "Default EC2 AMI"
  default     = "ami-042e6fdb154c830c5"
  type        = string
}

variable "ssh_key" {
  description = "Public SSH Key"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo3XcmuMT4puLL3Qgn62+kEoQq9l+B8Ek9muVseQWyk student@vincenzo-uvrq"
}