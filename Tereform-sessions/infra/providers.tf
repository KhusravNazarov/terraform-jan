provider "aws" {
  region = "us-west-2"
 default_tags {
   tags = {
    environment = var.env
    project     = var.project
    tier        = var.tier
    team        = var.team
    owner       = var.owner
    manager     = var.manager
   }
 }
}