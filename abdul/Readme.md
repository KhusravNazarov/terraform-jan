
terraform plan -var-file="clients.tfvars"

terraform apply -var-file="clients.tfvars"

Starting with the child module (modules/dns/main.tf):

resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

This creates a primary Route 53 hosted zone for the client's domain. The name is set to the domain_name provided in the variables.

######

resource "aws_route53_record" "primary_records" {
  for_each = var.records.primary

  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = each.key
  ttl     = 300
  records = each.value
}

This block creates DNS records for the primary domain:

######

for_each = var.records.primary: Iterates over each record type in the primary records.

zone_id: Sets the zone ID to the ID of the primary hosted zone created above.

name: Sets the record name to the primary domain name.

type: Sets the record type (A, CNAME, etc.) based on the current key in the for_each loop.

ttl: Sets the Time To Live for the record to 300 seconds.

records: Sets the record values based on the current value in the for_each loop.

resource "aws_route53_zone" "subdomains" {
  for_each = toset(var.subdomains)

  name = "${each.key}.${var.domain_name}"
}

This creates a hosted zone for each subdomain:
######
for_each = toset(var.subdomains): Iterates over each subdomain in the provided list.

name: Sets the zone name to the subdomain concatenated with the primary domain.

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


This complex block creates DNS records for each subdomain:


The for_each argument uses nested loops to create a flat map of all subdomain records.

zone_id: Sets the zone ID to the ID of the corresponding subdomain hosted zone.

name: Sets the record name to the full subdomain name.

type: Sets the record type based on the flattened map.

ttl: Sets the Time To Live for the record to 300 seconds.

records: Sets the record values based on the flattened map.

#####

Now, let's look at the root module (backend.tf):

terraform {
  backend "s3" {
    bucket = "bucket_name"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}


This block configures Terraform to use an S3 backend for storing the state file:

bucket: Specifies the S3 bucket name.

key: Specifies the path to the state file within the bucket.

region: Specifies the AWS region where the S3 bucket is located.

######

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


This defines the structure of the clients variable, which is a map where each key is a client identifier and the value is an object containing the client's configuration.

######

module "client_resources" {
  source   = "./modules/dns"
  for_each = var.clients

  domain_name   = each.value.domain_name
  subdomains    = each.value.subdomains
  dns_account_id = each.value.dns_account_id
  records       = each.value.records
}


This block creates an instance of the client module for each client defined in the clients variable:

source: Specifies the path to the client module.

for_each: Iterates over each client in the clients map.

The remaining lines pass the client's configuration to the module.

The outputs.tf files in both the root and child modules define outputs that can be used to retrieve information about the created resources.

This setup allows you to define multiple clients in your clients.tfvars file, and Terraform will automatically create the necessary Route 53 resources for each client when you apply the configuration.
