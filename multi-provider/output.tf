output "ec2_instance_ips" {
	value = module.ec2-instances[*].public_ip
	description = "The public IP address of the EC2 instances"
}

output "gcp_instance_ips" {
	value = module.gcp-instances[*].instance_ips
	description = "The public IP address of the GCP instances"
}