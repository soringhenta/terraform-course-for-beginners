variable "ec2-instance-type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.micro"
}

variable "ec2-tag" {
  description = "EC2 instance tag"
  type        = list(string)
  default     = ["i1", "i2"]
}

variable "ssh_key" {
  description = "SSH key"
  type        = string
  default     = ""
}

variable "securitygroups" {
    default = ""
}