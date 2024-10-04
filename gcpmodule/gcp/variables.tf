variable "gcp_instance_type" {
    description = "Default GCP Instance type"
}

variable "gcp_name" {
    description = "Instance name"
    validation {
      condition = length(var.gcp_name) >= 7
      error_message = "Name too old"
    }
}