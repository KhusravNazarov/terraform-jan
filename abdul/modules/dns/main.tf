
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "primary_records" {
  for_each = var.records.primary

  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = each.key
  ttl     = 300
  records = each.value
}

resource "aws_route53_zone" "subdomains" {
  for_each = toset(var.subdomains)

  name = "${each.key}.${var.domain_name}"
}

resource "aws_route53_record" "subdomain_records" {
  for_each = {
    for pair in flatten([
      for subdomain, records in var.records.subdomains : [
        for record_type, record_values in records : {
          key = "${subdomain}_${record_type}"
          subdomain = subdomain
          type  = record_type
          values = record_values
        }
      ]
    ]) : pair.key => pair
  }

  zone_id = aws_route53_zone.subdomains[each.value.subdomain].zone_id
  name    = "${each.value.subdomain}.${var.domain_name}"
  type    = each.value.type
  ttl     = 300
  records = each.value.values
}











