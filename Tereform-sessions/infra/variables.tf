variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-2"
}

variable "env" {
  type        = string
  description = "environment"
  default     = "dev"
}

variable "project" {
  type        = string
  description = "project name"
  default     = "jerry"
}


variable "tier" {
  type        = string
  description = "app tier"
  default     = "backend"
}
variable "team" {
  type        = string
  description = "team naem"
  default     = "cloud"
}
variable "owner" {
  type        = string
  description = "project owner"
  default     = "Khusrav"
}
variable "manager" {
  type        = string
  description = "project manager"
  default     = "Khusrav"
}
variable "resource_type" {
  type = string
  default = "vpc"
  description = "resource type"
}
variable "public_subnets" {
  type = list(string)
  default = [ "10.0.1.0/24",  "10.0.2.0/24"]

}
variable "private_subnets" {
  type = list(string)
  default = [ "10.0.10.0/24",  "10.0.11.0/24"]

}
variable "number" {
  type = list(number)
  description = "numbers for element function"
  default = [0,1]
}
variable "ami" {
  type = string
  default = "ami-0eb9d67c52f5c80e5"
  description = "ami id"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key" {
  default = "local-mac"
  description = "ssh key"
}
variable "ports" {
  type = list(string)
  default = [ "22", "80",  "443" ]
  description = "ports"
}
variable "cidr_allow" {
  default = "0.0.0.0/0"
}