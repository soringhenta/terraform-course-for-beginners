# Add the random provider
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 6.0" # Use a compatible version
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0" # Use a compatible version
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  project = "vdnptest" # REPLACE WITH YOUR GCP PROJECT ID
  region  = "europe-central3"         # You can change this to your desired region
}

# --- Generate a unique suffix for the bucket name ---
resource "random_id" "bucket_suffix" {
  byte_length = 8
}

# --- Check for Existing Bucket ---

# Define the base name of the bucket. The unique suffix will be added during creation.
# For checking, we still need to derive the potential full name.
locals {
  # We construct a desired bucket name that is very likely to be unique.
  # Adjust "my-app-bucket" to something relevant to your application.
  desired_bucket_base_name = "my-app-bucket"
  # This is the full name Terraform will attempt to create if it doesn't exist.
  # It's important to use the same logic here as in the resource block.
  potential_full_bucket_name = "${local.desired_bucket_base_name}-${random_id.bucket_suffix.hex}"
}

# Data source to retrieve a list of GCS buckets in the project.
# We will search for the potentially existing bucket with the *full* generated name.
data "google_storage_buckets" "all_buckets" {
  project = "vdnptest" # REPLACE WITH YOUR GCP PROJECT ID
  # Using a prefix can help narrow down the API call results if you have many buckets,
  # but the final check with 'one' is still for the exact name.
  prefix = local.desired_bucket_base_name # Filter by base name for efficiency
}

# Local value to determine if the bucket exists by checking the list of all buckets.
locals {
  # Iterates through the list of buckets found by the data source.
  # It checks if any of the *existing* buckets in *your project* match the
  # *potential full bucket name* we want to use.
  found_bucket = one([for bucket in data.google_storage_buckets.all_buckets.buckets : bucket if bucket.name == local.potential_full_bucket_name])

  # This boolean flag indicates if the bucket with the potential_full_bucket_name was found.
  bucket_found_flag = local.found_bucket != null
}

# --- Conditionally Create Bucket ---

# Resource to create the GCS bucket.
# 'count = local.bucket_found_flag ? 0 : 1' means:
# - If 'bucket_found_flag' is true (bucket exists with the generated name), count is 0, so no bucket is created.
# - If 'bucket_found_flag' is false (bucket with the generated name does not exist), count is 1, so the bucket is created.
resource "google_storage_bucket" "new_bucket_if_not_exists" {
  count = local.bucket_found_flag ? 0 : 1

  # The name of the bucket to create. It MUST use the generated unique name.
  name          = local.potential_full_bucket_name
  location      = "EU" # Choose your desired location (e.g., "EUROPE", "ASIA")
  project       = "vdnptest" # REPLACE WITH YOUR GCP PROJECT ID
  storage_class = "STANDARD"
  uniform_bucket_level_access = true # Recommended for security
  force_destroy = true
  
}

# --- Outputs ---

# Output to confirm if the bucket was found by the data source.
output "data_source_bucket_found_status" {
  description = "Indicates if the GCS bucket with the generated name was found by the data source."
  value       = local.bucket_found_flag
}

# Output the name of the bucket that was either found or created.
output "final_bucket_name" {
  description = "The name of the GCS bucket (existing or newly created)."
  value       = local.bucket_found_flag ? local.found_bucket.name : google_storage_bucket.new_bucket_if_not_exists[0].name
}

# Output the self_link of the bucket.
output "final_bucket_self_link" {
  description = "The self-link of the GCS bucket (existing or newly created)."
  value       = local.bucket_found_flag ? local.found_bucket.self_link : google_storage_bucket.new_bucket_if_not_exists[0].self_link
}