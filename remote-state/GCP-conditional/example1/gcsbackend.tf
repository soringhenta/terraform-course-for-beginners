locals {
  bucket_name = "gcsbackend"
}

# resource "google_storage_bucket" "terraform_state_bucket" {
#   name          = local.bucket_name
#   location      = "europe-west3" # Choose your desired location
#   force_destroy = true # Enable force destroy to allow bucket deletion
#   storage_class = "STANDARD"

#   versioning {
#     enabled = true
#   }

#   uniform_bucket_level_access = true
# }

data "google_storage_buckets" "all_buckets" {
  project = "vdnptest" # REPLACE WITH YOUR GCP PROJECT ID
  # You can add a prefix here if you expect many buckets and want to optimize the lookup, e.g.:
  # prefix = local.desired_bucket_name
}
locals {
  # Iterates through the list of buckets found by the data source.
  # The 'one' function will return the matching bucket if exactly one is found,
  # otherwise it will return null or an error if multiple match (not expected with exact name).
  found_bucket = one([for bucket in data.google_storage_buckets.all_buckets.buckets : bucket if bucket.name == local.bucket_name])

  # This boolean flag indicates if the bucket was found.
  bucket_found_flag = local.found_bucket != null
}

resource "google_storage_bucket" "new_bucket_if_not_exists" {
  count = local.bucket_found_flag ? 0 : 1

  # The name of the bucket to create. It MUST match the name defined in locals.
  name          = local.bucket_name
  location      = "EU" # Choose your desired location (e.g., "EUROPE", "ASIA")
  project       = "vdnptest" # REPLACE WITH YOUR GCP PROJECT ID
  storage_class = "STANDARD"
  uniform_bucket_level_access = true # Recommended for security
}

# --- Outputs ---

# Output to confirm if the bucket was found by the data source.
output "data_source_bucket_found_status" {
  description = "Indicates if the GCS bucket was found by the data source."
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