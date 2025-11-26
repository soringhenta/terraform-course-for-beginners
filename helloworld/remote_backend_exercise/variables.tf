variable "region" {
  default     = "eu-central-1"
  description = "Default AWS zone"
}

variable "type" {
  description = "Default instance type"
  default     = "t3.micro"
  validation {
    condition     = var.type == "t3.micro" || var.type == "t2.micro"
    error_message = "Invalid instance type"
  }
}

variable "ssh_port" {
  default     = 22
  type        = number
  description = "Default SSH port"
}


variable "ssh_keyname" {
  default     = "mykey"
  type        = string
  description = "Default key name"
}

variable "statefilename" {
  default = "sorin/terraform.tfstate"
  description = "Default remote backend path"
}

