# resource "google_compute_network" "test_vpc" {
#   name = var.name
# }

resource "google_compute_router" "cloudcr" {
  name    = var.cloud_router_name
  region = "us-central1"
  network = google_compute_network.test_vpc.id
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "10.128.0.0/20"
    }
  }
}

resource "google_compute_network" "test_vpc" {
  name                    = var.name
}