output "client_primary_zone_ids" {
  value = { for client, module in module.client_resources : client => module.primary_zone_id }
}

output "client_subdomain_zone_ids" {
  value = { for client, module in module.client_resources : client => module.subdomain_zone_ids }
}
