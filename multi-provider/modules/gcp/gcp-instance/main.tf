locals {
    count = 1
}

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  most_recent = true
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "gcp-instance" {
  name         = "gcp-instance2"
  machine_type = var.gcp-type

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.id
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "sudo apt install -y apache2; sudo systemctl start apache2"
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