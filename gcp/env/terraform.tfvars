
vpn_config = {  
 ha_gateway = {    
    gw-ue4 = {       
      region  = "us-east4"       
      network = "https://www.googleapis.com/compute/v1/projects/gcp-demo-416310/global/networks/ensono-managed-wan-vpc" 
      } 


routers = {     
   vpn-ue4-cr = {       
    region = "us-east4"       
    bgp = {         
      asn            = "64921"         
      advertise_mode = "CUSTOM"         
      advertised_ip_ranges = [           
        { range = "10.110.0.0/15" },
         ]      
       }       
        network = "https://www.googleapis.com/compute/v1/projects/gcp-demo-416310/global/networks/ensono-managed-wan-vpc"    
      },
 tunnels = {     
    remote-0 = {       
      region = "us-east4"      
      bgp_peer = {         
        address  = "169.254.16.1"         
        asn      = 64920         
        priority = 800       
       }       
       bgp_session_range     = "169.254.16.2/30"       
       ike_version           = 2       
       vpn_gateway_interface = 0       
       vpn_gateway_key       = "ensono-managed-wan-vpc-gw-ue4"       
       router_key            = "ensono-managed-wan-vpc-vpn-ue4-cr"       
       peer_gcp_gateway      = "https://www.googleapis.com/compute/v1/projects/datacenter-in-the-cloud9b856e0/regions/us-east4/vpnGateways/dtic-nprd-wan-vpn-gw-ue4"    
      }, 

    }
   }
  }
}   


