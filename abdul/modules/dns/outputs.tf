output "primary_zone_id" {
  value = aws_route53_zone.primary.zone_id
}

output "subdomain_zone_ids" {
  value = { for subdomain, zone in aws_route53_zone.subdomains : subdomain => zone.zone_id }
}

