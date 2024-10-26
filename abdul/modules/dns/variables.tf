variable "domain_name" {
  type = string
}

variable "subdomains" {
  type = list(string)
}

variable "dns_account_id" {
  type = string
}

variable "records" {
  type = object({
    primary = map(list(string))
    subdomains = map(map(list(string)))
  })
}









