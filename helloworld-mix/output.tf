output "public_ip" {
    description = "Public EC2 instance IP"
    value = aws_instance.helloworld.public_ip
    sensitive = true
}