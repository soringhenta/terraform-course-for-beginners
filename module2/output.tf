output "instance_ips" {
	value = module.ami-data[*].public_ip
	description = "The public IP address of the web server"
}

output "amiobject" {
	value = module.data-source.ubuntu
}