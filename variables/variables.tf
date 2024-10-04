variable "os" {
    default = "ami-023adaba598e661ac"
    type = string
    description = "Default AWS AMI ID for eu-central-1 region"
}

variable "type" {
  default = "t2.micro"
  type = string
  description = "Default AWS Instance type"
}
