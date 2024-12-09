variable "ssh_port" {
  description = "SSH Service Port"
  type        = number
  default     = 22
}

variable "default_ami" {
  description = "Default AMI for eu-central-1 region"
  type        = string
  default     = "ami-042e6fdb154c830c5"
}

variable "default_itype" {
  description = "Default Instance type for eu-central-1 region"
  type        = string
  validation {
    condition     = var.default_itype == "t2.micro"
    error_message = "Only t2.micro allowed"
  }
}