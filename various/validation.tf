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

variable "test_text" {
    description = "Example of text content"
    type = string
    default = "test-1"
    validation {
	condition = substr(var.test_text, 0, 4) == "test"
	error_message = "Variable must start with test"
    }
}

variable "test_text2" {
    description = "Example of text content"
    type = string
    default = "test-1"
    validation {
	condition = substr(var.test_text2, 0, 4) == "test" && length(var.test_text2) >= 5
	error_message = "Variable must start with test and lenght more/equal than 5"
    }
}