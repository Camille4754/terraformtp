resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-bucket-tp"
  location = var.region
}
