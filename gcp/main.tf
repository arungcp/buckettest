
module "gcp" {
  source = "./modules/terraform"
  name = var.name
  location = var.location
  
}