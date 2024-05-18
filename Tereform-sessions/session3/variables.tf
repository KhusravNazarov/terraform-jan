variable "env" {
    type = string
    description = "this variable is for enviroment"  //Description
    default = "dev"  //Default value for variable
  
}
variable "ports" {
  type = list(number)
  description = "a list of port numbers"
  default = [22, 3306, 443]

}