resource "google_compute_instance" "gcp-instance" {
  name         = "${var.gcp_name}"
  machine_type = "${var.gcp_instance_type}"
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2404-noble-amd64-v20240608"
    }
  }
  labels = {
    name = "hello_world"
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}