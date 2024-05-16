
    
resource "aws_instance" "web" {
  ami           = "ami-01cd4de4363ab6ee8"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-instance-session"
  }
}






// each Terraform confuguration file has .tf
# There are 2 main blocks in Terraform 
# 1. resource Block = Create and manage (aws services or Infrastructure)
#  - resource block expects 2 labels
# 2. Data source Block = ? 


# Syntax:
# resource = block 
# aws_instance - first label, (resource type), predefined by Terraform 
# web = second label , (logical name or id), unique and defined by Author 
# ami = argument, consist of key and value 
# -Key = pre defined by terraform 
# -value is defined by Author
//Working Directory
// - place where you run Terraform commands 
// - place where yo have terraform Configuration Files 
// - Root Module


//terraform has Backend (terraform.tfstate)
// - local Backend = gets generated in the same working directory 
// - remote Backend =  gets generated in the remote system such s3 bucket 

// What is the Backend?
// - Stores your infrastructure information
// - 