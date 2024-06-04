terraform {
  backend "s3" {
    bucket = "terraform-khusrav"
    key    = "terraform.tfstate" //Path to your remote Backend file (terraform.tfstate)
    region = "us-west-2"
    workspace_key_prefix = "workspaces"
  }
}
# currently : default
# Backend File Path: workspaces/terraform.tfstate 

# New : dev 
# Backend File Path: workspaces/dev/terraform.tfstate 
# New : stage 
# Backend File Path: workspaces/stage/terraform.tfstate 