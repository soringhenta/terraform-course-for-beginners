output "public_ip" {
  value       = aws_instance.helloworld.public_ip
  description = "The public IP address of the web server"
}

output "public_dns" {
  description = "Public DNS FQDN"
  value = aws_instance.helloworld.public_dns
}