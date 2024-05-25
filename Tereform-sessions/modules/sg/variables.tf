variable "env" {
  type = string
  default = "dev"
  description = "environment"
}
variable "ports" {
  type = list(string)
  default = [ "22", "80",  "443" ]
  description = "ports"
}