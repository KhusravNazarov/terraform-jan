resource "aws_default_vpc" "main" {
    tags = merge(
        {Name = replace(local.Name, "rtype", "vpc")}, 
        local.common_tags
    )
  
}
resource "aws_default_subnet" "public_subnet_1" {
  availability_zone = "us-west-2a"
  tags = merge(
        {Name = replace(local.Name, "rtype", "public_subnet_1")}, 
        local.common_tags
  )
}
resource "aws_default_subnet" "public_subnet_2" {
  availability_zone = "us-west-2b"
  tags = merge(
        {Name = replace(local.Name, "rtype", "public_subnet_2")}, 
        local.common_tags
  )
}