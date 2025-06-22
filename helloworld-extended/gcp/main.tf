provider "google" {
  project = "vdnptest"
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
    name = "hello-world"
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    name = "Gcp-instance"
    ssh-keys = "denaropapa:${var.ssh_key} denaropapa"
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall2"
  network = google_compute_instance.gcp-instance.network_interface[0].network
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
}
