provider "google" {
  project = "tfundamental"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}

resource "random_string" "random" {
  length           = 7
  special          = false
  lower            = true
  override_special = "/@$"
}

module "gcp-compute" {
    source = "./gcp"
    gcp_instance_type = "e2-micro"
    gcp_name = lower(random_string.random.id)
}