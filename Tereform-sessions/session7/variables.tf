variable "env" {
  type = string
  description = "environment"
  default = "dev"

}
variable "team" {
  type = string
  description = "team"
  default = "devops"

}
variable "project" {
  type = string
  description = "project"
  default = "nemo"
}
variable "app" {
  type = string
  description = "application"
  default = "dory"
}
variable "ec2-ports" {
  type = list(object({
    port = number 
    protocol = string
  }
  ))
  default = [ {
    port = 80
    protocol = "tcp"
  },
  {
    port = 22
    protocol = "tcp"
  } ]
}
variable "alb-ports" {
  type = list(object({
    port = number 
    protocol = string
  }
  ))
  default = [ {
    port = 80
    protocol = "tcp"
  },
  {
    port = 443
    protocol = "tcp"
  } ]
}
variable "instance_type" {
  default = "t2.micro"
}

variable "aws_route53_zone_id" {
    type = string
  default = "Z04406951HZ41R5YEQ3HT"
}
variable "version" {
  default =  "sdfa"
}