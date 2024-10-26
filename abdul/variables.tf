variable "clients" {
  type = map(object({
    domain_name   = string
    subdomains    = list(string)
    dns_account_id = string
    records = object({
      primary = map(list(string))
      subdomains = map(map(list(string)))
    })
  }))
}