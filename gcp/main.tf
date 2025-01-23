
module "gcp" {
  source   = "./modules/terraform"
  name     = var.name
  location = var.location

}


 module "dnb_ensono_vpc" {   
   source     = "app.terraform.io/dnb-core/dnb_gcp_vpc/google"   
   #version    = "0.0.3"   
   name       = var.name   
   project_id = var.project_id 
  } 

resource "google_compute_ha_vpn_gateway" "ha_gateway" {   
  for_each = { for i, v in var.vpn_config["ha_gateway"] : i => v }   
  provider = google-beta   
  name     = "${var.name}-${each.key}"   
  project  = var.project_id   
  region   = each.value.region   
  network  = each.value.network 
 } 

 module "router" {   
  source      = "app.terraform.io/dnb-core/dnb-cloudrouter/google"   
  #version     = "2.0.2"   
  for_each = { for i, v in var.vpn_config["routers"] : i => v }   
  name        = "${var.name}-${each.key}"   
  project     = var.project_id   
  region      = each.value.region  
  network     = each.value.network   
  bgp         = each.value.bgp   
  environment = var.name
 }

 resource "google_compute_router_peer" "bgp_peer" {   
   for_each = var.vpn_config["tunnels"]   
   region   = each.value.region   
   project  = var.project_id   
   name     = "${var.name}-${each.key}"   
   # This resource wants just the name and module doesn't output name, hack to split and grab last index  
   # Needs to be refactored   
   router          = each.value.router_key   
   peer_ip_address = each.value.bgp_peer.address   
   peer_asn        = each.value.bgp_peer.asn   
   interface       = google_compute_router_interface.router_interface[each.key].name   
   advertised_route_priority = each.value.bgp_peer.priority
  }

 resource "google_compute_router_interface" "router_interface" {   
   provider = google-beta   
   for_each = var.vpn_config["tunnels"]   
   project  = var.project_id   
   region   = each.value.region  
   name     = "${var.name}-${each.key}"   
   # This resource wants just the name and module doesn't output name, hack to split and grab last index   
   # Needs to be refactored   
   router     = each.value.router_key   
   ip_range   = each.value.bgp_session_range   
   vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].name
  }

 resource "google_compute_vpn_tunnel" "tunnels" {   
   provider              = google-beta   
   for_each              = var.vpn_config["tunnels"]   
   project               = var.project_id   
   region                = each.value.region   
   name                  = "${var.name}-${each.key}"   
   router                = each.value.router_key   
   peer_gcp_gateway      = each.value.peer_gcp_gateway   
   vpn_gateway_interface = each.value.vpn_gateway_interface   
   ike_version           = each.value.ike_version   
   shared_secret         = var.vpn_psk   
   vpn_gateway           = each.value.vpn_gateway_key 
  }

