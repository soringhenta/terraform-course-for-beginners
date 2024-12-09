data "google_compute_image" "my_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

output "gcp_image" {
  value = data.google_compute_image.my_image
}

