module "inside-vpc" {
  source            = "./modules/terraform/network"
  name              = var.name
  cloud_router_name = var.cloud_router_name
}

