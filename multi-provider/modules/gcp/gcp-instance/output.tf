output "instance_ips" {
  value = "${join(" ", google_compute_instance.gcp-instance.*.network_interface.0.access_config.0.nat_ip)}"
  description = "The public IP address of the newly created instance"
}