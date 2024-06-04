locals {
  Name = "aws-${var.team}-${var.project}-${var.app}-rtype-${var.env}"
  common_tags = {
    Environment = var.env
    Team = var.team,
    Application = var.app
    Project = var.project
    Owner = "Khusrav"
    Managed_by = "terraform"
  }
  asg_tags = merge(
    {Name = replace(local.Name, "rtype", "asg")},
    local.common_tags
  )
}