# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.8.1"
# }
module "ec2" {
  source = "github.com/KhusravNazarov/terraform-jan//Tereform-sessions/modules/ec2?ref=v1.0.0"
  env = "dev"
  ami = "ami-01cd4de4363ab6ee8"
  instance_type = "t2.micro"
  sg = [module.sg.security_group_id]

}

module "sg" {
  source = "github.com/KhusravNazarov/terraform-jan//Tereform-sessions/modules/sg?ref=v1.0.0"
  env = "dev"
  ports = [ "22", "80",  "443" ]
 
}
# infra code should be going only from main branch