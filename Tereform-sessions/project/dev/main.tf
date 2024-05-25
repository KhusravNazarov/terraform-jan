module "ec2" {
  source = "../../modules/ec2"
#   version = "value"
env = "dev"
ami = "ami-01cd4de4363ab6ee8"
instance_type = "t2.micro"
sg = [module.sg.security_group_id]
}
module "sg" {
  source = "../../modules/sg"
  env = "dev"
  ports = [ "22", "80",  "443" ]
 
}
# referrence to  module
# syntax = module.module_name.output_name