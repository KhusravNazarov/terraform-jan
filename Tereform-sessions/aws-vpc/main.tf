resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform-vpc"
  }
}

///subnets/// 3public and 3 private
resource "aws_subnet" "public" {
  count = 3
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.pub_cidr, count.index)
  availability_zone = element(var.oregon_azs, count.index)

  tags = {
    Name = "public-sub-1"
  }
}
# resource "aws_subnet" "public2" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.2.0/24"
#   availability_zone = "us-west-2b"

#   tags = {
#     Name = "public-sub-2"
#   }
# }
# resource "aws_subnet" "public3" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.3.0/24"
#   availability_zone = "us-west-2d"

#   tags = {
#     Name = "public-sub-3"
#   }
# }
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private-sub-1"
  }
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private-sub-2"
  }
}
resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "us-west-2d"

  tags = {
    Name = "private-sub-3"
  }
}
////Ruote tables /// 
resource "aws_route_table" "public_route_table" {
   vpc_id = aws_vpc.main.id
     tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table" "private_route_table" {
   vpc_id = aws_vpc.main.id
     tags = {
    Name = "private-route-table"
  }
}
///aws_route_table_association///
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private_route_table.id
}
///aws_internet_gateway///
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id  //attach to vpc

  tags = {
    Name = "internet-gateway"
  }
  ///aws_eip///
}
resource "aws_eip" "eip" {
    tags = {
    Name = "eip"
    }
}
///aws_nat_gateway///
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "nat-gateway"
  }
}
/// add aws_route ///
resource "aws_route" "internet_gateway_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id 
}
resource "aws_route" "nat_gateway_route" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id 
}
