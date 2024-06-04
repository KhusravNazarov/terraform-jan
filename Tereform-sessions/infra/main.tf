//////  vpc /////////
resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
#   tags = local.standard_tags

    tags = {
    Name = "vpc-${local.Name}"
  }
 
}
 //////private and public subnets//////////
 resource "aws_subnet" "private_subnets" {
    vpc_id = aws_vpc.main_vpc.id  // first_lable.second_lable.id
    
    count = length(var.private_subnets)
    cidr_block = element(var.private_subnets, count.index)
    tags = {
     Name = "private-${element(var.number, count.index)}"
    }
  


 }
  resource "aws_subnet" "public_subnets" {
    vpc_id = aws_vpc.main_vpc.id  // first_lable.second_lable.id
    count = length(var.public_subnets)
    cidr_block = element(var.public_subnets, count.index)
    tags ={
     Name = "public-${element(var.number, count.index)}"
    }

 }
 ////  route tables /// 
 resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

   tags ={
     Name = "public_rout-${local.Name}"
   }
 }
  resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

   tags = {
     Name = "private_rout-${local.Name}"
    }
  
 }
 //////////  internet gateway /////////////////////////
 resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id //attach to vpc

    tags ={
     Name = "int_gateway-${local.Name}"
    }
}
/////////// subnet association ////////////
resource "aws_route_table_association" "private" {
    count = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "public" {
    count = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}

///////// aws elastic ip ///////////////////
resource "aws_eip" "eip" {
    tags = {
    Name = "eip-${local.Name}" 
    }
}
///aws_nat_gateway///
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets.0.id   ///attaching to the public subnet 

  tags = {
    Name = "nat-gateway-${local.Name}" 
  }
}
/// add aws_route ///
resource "aws_route" "internet_gateway_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = var.cidr_allow  // allow 0.0.0.0/0
  gateway_id = aws_internet_gateway.main_gateway.id 
}
resource "aws_route" "nat_gateway_route" {
  route_table_id            = aws_route_table.private_route_table.id
  destination_cidr_block    = var.cidr_allow
  nat_gateway_id = aws_nat_gateway.nat_gateway.id 
}
///////////// aws launch template ////////
resource "aws_launch_template" "launch_template" {
    name = "linux-template-${local.Name}" 
    image_id = var.ami
network_interfaces {
  security_groups = [aws_security_group.security_http.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnets.0.id
  delete_on_termination       = true 
}
   

  instance_type = var.instance_type
  //vpc_security_group_ids = ["sg-0981df1e6ff9920e3"]
  key_name = var.key
    
  }

 resource "aws_security_group" "security_http" {
  # name        = "sg-${local.Name}"
  description = "Allow TLS inbound traffic and all outbound traffic"
}
//how to reference ti Resiyrce?
//In order to Reference to Resource, we use lables (firstlable.secondlable.attribute)
resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.security_http.id
  count = length(var.ports)
  cidr_ipv4         = var.cidr_allow
  from_port         = element(var.ports, count.index)
  ip_protocol       = "tcp"
  to_port           = element(var.ports, count.index)
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.security_http.id
  cidr_ipv4         = var.cidr_allow
  ip_protocol       = "-1" # semantically equivalent to all ports
} 




