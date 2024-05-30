variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr block  range"

  
}
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