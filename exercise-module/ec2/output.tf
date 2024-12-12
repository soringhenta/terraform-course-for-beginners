output "public_ip" {
  value       = { for i in aws_instance.ec2_instances : i.id => "${i.public_ip}" }
  description = "The public IP address of the 2 EC2 instances"
}