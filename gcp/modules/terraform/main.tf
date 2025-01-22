resource "google_storage_bucket" "auto-expire" {
  name          = var.name
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}