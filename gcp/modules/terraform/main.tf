resource "google_storage_bucket" "auto-expire" {
  project = ""
  name          = var.name
  location      = var.location
  force_destroy = true
  public_access_prevention = "enforced"
}