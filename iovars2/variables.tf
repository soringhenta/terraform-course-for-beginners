variable "ssh_port" {
  description = "SSH Service Port"
  type        = number
}

variable "ec2_tag" {
  description = "EC2 instance tag"
  type        = list(string)
}

variable "ec2_instance_type" {
  description = "EC2 Instance type"
  type        = string
}
