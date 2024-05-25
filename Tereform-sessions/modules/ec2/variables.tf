variable "env" {
  type = string
  default = "dev"
  description = "enviroment"
}
variable "ami" {
  type = string
  default = "ami-01cd4de4363ab6ee8"
  description = "ami id"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "instance type"
}
variable "sg" {
  type = list(string)
  description = "security group id "
  default = [ "" ]
}