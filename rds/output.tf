output "ssh_public_key" {
  value = tls_private_key.ed25519-key.public_key_openssh
}

output "ssh_pvt_key" {
  value     = tls_private_key.ed25519-key.private_key_openssh
  sensitive = true
}

output "ec_public_ip" {
  value = aws_instance.tf_example.public_ip
}

output "ec_private_ip" {
  value = aws_instance.tf_example.private_ip
}

output "rds_hostname" {
  value = aws_db_instance.tf_db.address
}

output "rds_password" {
  value     = random_password.password.result
  sensitive = true
}