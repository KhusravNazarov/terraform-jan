// Naming Convention: Naming Standard
locals {
  name = "aws-${var.region}-${var.env}-${var.project}-${var.tier}-sqs"
  common_tags = {
    environment = var.env
    project     = var.project
    tier        = var.tier
    team        = var.team
    owner       = var.owner
    manager     = var.manager


  }
}