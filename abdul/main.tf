module "client_resources" {
  source   = "./modules/dns"
  for_each = var.clients

  domain_name   = each.value.domain_name
  subdomains    = each.value.subdomains
  dns_account_id = each.value.dns_account_id
  records       = each.value.records
}







