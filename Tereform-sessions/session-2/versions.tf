terraform {
  required_version = ">=1.8.0, <1.9"  // terraform version 
  required_providers {       //provider version 
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.49.0" //lazy constraint
    }
  }
}
# 1.8.3 = symetic version 
# 1 = Major(upgrade) = Main Changes 
# 8 = Minor(update) = Features / enhancements 
# 7 = Patch (patching) = fix vulnarability 

# 1.8.0 ---> 1.8.x  = (>=1.8, <1.6), (~> 1.5.0)
# lazy constraints: (~> 1.5.0)
