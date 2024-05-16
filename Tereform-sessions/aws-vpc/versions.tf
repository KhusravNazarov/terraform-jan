terraform {
  required_version = ">=1.8.0, <1.9"  // terraform version 
  required_providers {       //provider version 
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.49.0" //lazy constraint
    }
  }
}