terraform {
  backend "s3" {
    bucket = "terraform-khusrav"
    key = "session4/terraform.tfstate"  //Path to your remote Backend file (terraform.tfstate)
    region = "us-west-2"
  }
}