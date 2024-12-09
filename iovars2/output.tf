output "public_ip" {
  value       = { for i in aws_instance.helloworld : i.id => "${i.public_ip}" }
  description = "The public IP address of the web server"
  sensitive   = true
}
