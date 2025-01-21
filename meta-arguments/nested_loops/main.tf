# merge function https://developer.hashicorp.com/terraform/language/functions/merge
# expand function https://developer.hashicorp.com/terraform/language/expressions/function-calls#expanding-function-arguments

locals {
 data  = yamldecode(file("./instances.yaml"))
 dev   = merge([for data in local.data : { for instance_key, instance_value in data : instance_key => instance_value if instance_value.env == "dev" }]...)
 stage = merge([for data in local.data : { for instance_key, instance_value in data : instance_key => instance_value if instance_value.env == "stage" }]...)
 micro = merge([for data in local.data : { for instance_key, instance_value in data : instance_key => instance_value if instance_value.shape == "t2-micro"}]...)
}

output "dev" {
 value = local.dev
}

output "stage" {
  value = local.stage
}