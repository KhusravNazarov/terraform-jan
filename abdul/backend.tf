terraform {
  backend "s3" {
    bucket         = "dns-hz-s3-khusrav"   
    key            = "state/terraform.tfstate"  
    region         = "us-east-1"                     
    encrypt        = true                      
  }
}