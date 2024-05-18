terraform {
  backend "s3" {
    bucket = "terraform-khusrav"
    key = "asg/terraform.tfstate"  //Path to your remote Backend file (terraform.tfstate)
    region = "us-west-2"
  }
}