variable "name" {
  description = "The name for the resource"
  type        = string
  default     = "default_value"
}


variable "location" {
  description = "The name for the region"
  type        = string
  default     = "default_value"
}

variable "project_id" {   
   description = "Project to run admin commands against"   
   type        = string 
}

variable "vpn_psk" {
  description = "PSK used for VPN tunnels"
  type = number
  sensitive = true
}
 variable "name" {   
   description = "Name of VPC"   
   type        = string 
} 
  variable "router_map" {
    description = "Cloud Router Map Configuration"   
   type        = map(any) 
} 

 variable "vpn_config" { 
   description = "VPN configuration"   
   type        = any 
 }
 variable "enviornment" {  
   description = "Short project/environment name"   
   type = string   
   default = "prj" 
  } 
  variable "prod_suffix" {   
    description = "Is project prod or nprd?"   
    type = string   
    default = "default"
 }