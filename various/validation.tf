variable "list_example" {
    description = "An example of a list in Terraform"
    type = list
     default = ["a", "b", "c"]
    #default = ["a", "b"]
    validation {
      condition = length(var.list_example) >= 3
      error_message = "Too few elements"
    }
}
