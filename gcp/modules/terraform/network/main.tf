# resource "google_compute_network" "test_vpc" {
#   name = var.name
# }

resource "google_compute_router" "cloudcr" {
  name    = var.cloud_router_name
  network = google_compute_network.test_vpc.id
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "1.2.3.4"
    }
    advertised_ip_ranges {
      range = "6.7.0.0/16"
    }
  }
}

# resource "google_compute_network" "test_vpc" {
#   name                    = "my-network"
#   auto_create_subnetworks = false
# }