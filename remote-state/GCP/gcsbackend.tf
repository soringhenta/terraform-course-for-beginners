locals {
  bucket_name = "gcsbackend"
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name          = local.bucket_name
  location      = "europe-west3" # Choose your desired location
  force_destroy = true # Enable force destroy to allow bucket deletion
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}