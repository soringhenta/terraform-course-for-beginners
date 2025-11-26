locals {
  aws_region = "eu-central-1"
}

variable "aws_region" {
  type = string
  default = "eu-central-1"
  description = "Default AWS region"
}

variable "aws_ami" {
  type = string
  default = "ami-023adaba598e661ac"
  description = "Ami instance"
}

variable "ssh_port" {
  type = number
  default = 22
  description = "Default SSH port"
}

variable "ssh_key" {
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDElqHWygSNjmToOwKtg1q20ukMEuZtectyhCmaN163t student@ghenta-pvyl"
  description = "Personal SSH key"
}

variable "ssh_config" {
    type = object({
      port = number
      key = string
    })
    default = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDElqHWygSNjmToOwKtg1q20ukMEuZtectyhCmaN163t student@ghenta-pvyl"
      port = 22
    }
}

output "ec2_public_ip" {
  value = aws_instance.helloworld.public_ip
}

output "ec2_az" {
  value = aws_instance.helloworld.availability_zone
}

