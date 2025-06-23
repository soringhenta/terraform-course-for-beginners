provider "google" {
  project = "tfundamental"
  region  = "europe-west3"
  zone    = "europe-west3-a"
  credentials = "/home/nirvana/Downloads/tfundamental-ec8d739476c9.json"
}

# Create the random password
resource "random_password" "password" {
  length           = 16
  special          = true
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "secret"

  labels = {
    label = "my-label"
  }
  replication {
    auto {
    }
  }
}

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id
  secret_data = random_password.password.result
}

data "google_secret_manager_secret" "secret_data" {
  secret_id = google_secret_manager_secret.secret-basic.secret_id
}

data "google_secret_manager_secret_version" "password" {
  # secret = google_secret_manager_secret.secret-basic.id
  secret = data.google_secret_manager_secret.secret_data.id
  depends_on = [google_secret_manager_secret_version.secret-version-basic]
}

data "http" "myip" {
  url = "https://ipinfo.io/ip"
}

output "db_password" {
	value = data.google_secret_manager_secret_version.password.secret_data
	sensitive = true
}

output "myip" {
  value = data.http.myip.response_body
}

resource "google_sql_database_instance" "mysql_demo_db" {
  name = "db"
  deletion_protection = false
  database_version = "MYSQL_8_0"
  region  = "europe-west3"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        value = "${chomp(data.http.myip.response_body)}/32"
      }
    }
  }
  depends_on = [ data.http.myip ]
  root_password = data.google_secret_manager_secret_version.password.secret_data
}

resource "google_sql_user" "users" {
  name     = "vdnp"
  instance = google_sql_database_instance.mysql_demo_db.name
  host     = "%"
  password = data.google_secret_manager_secret_version.password.secret_data
}

# data "google_sql_tiers" "tiers" {
#   project = "tfundamental"
# }

# locals {
#   all_available_tiers = [for v in data.google_sql_tiers.tiers.tiers : v.tier]
# }

# output "avaialble_tiers" {
#   description = "List of all available tiers for give project."
#   value       = local.all_available_tiers
# }