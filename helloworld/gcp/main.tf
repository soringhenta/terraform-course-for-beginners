provider "google" {
  project = "tfundamental"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}

resource "google_compute_instance" "gcp-instance" {
  name         = "gcp-instance2"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2404-noble-amd64-v20240608"
    }
  }
  labels = {
    name = "helloworld"
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
