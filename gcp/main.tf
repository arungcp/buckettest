module "inside-vpc" {
  source = "./modules/terraform/network"
  name   = var.name
}