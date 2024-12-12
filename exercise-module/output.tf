output "instance_ips" {
	value = module.ec2_instances[*].public_ip
	description = "The public IP address of the web server"
}

output "public_key" {
  value = module.ssh-key.mynewkey
}

output "s3bucket" {
    value = module.remote-backend.bucketname.id
}