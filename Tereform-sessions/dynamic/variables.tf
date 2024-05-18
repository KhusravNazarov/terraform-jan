variable "public_cidr" {
  type        = list(string)
  description = "The CIDR for public subnets "
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "private_cidr" {
  type        = list(string)
  description = "The CIDR for private subnets "
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}
variable "oregon_azs" {
  type        = list(string)
  description = "az's in Oregon "
  default     = ["us-west-2a", "us-west-2b", "us-west-2d"]
}