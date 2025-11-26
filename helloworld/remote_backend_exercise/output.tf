output "name" {
  value = aws_s3_bucket.s3remote-sorin
}
# output "public_ip" {
#   value = aws_instance.instance.public_ip
# }

output "public_ip" {
  value = module.ec2.public_ip
}

output "private_key" {
  value     = tls_private_key.sshkey.private_key_openssh
  sensitive = true
}

output "securitygroup_name" {
  value = aws_security_group.incomingfw.name
}

