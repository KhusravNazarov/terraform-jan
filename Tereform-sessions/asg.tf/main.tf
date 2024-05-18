resource "aws_launch_template" "launch_template" {
    name = "my-launch-template"
    image_id = "ami-01cd4de4363ab6ee8"
network_interfaces {
  security_groups = [aws_security_group.security_http.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public1.id
  delete_on_termination       = true 
}
   

  instance_type = "t2.micro"
  //vpc_security_group_ids = ["sg-0981df1e6ff9920e3"]
  key_name = "local-mac"
    
  }

 resource "aws_security_group" "security_http" {
  name        = "web"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  tags = {
    Name = "web"
  }
}
//how to reference ti Resiyrce?
//In order to Reference to Resource, we use lables (firstlable.secondlable.attribute)
resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.security_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.security_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
} 
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform-vpc"
  }
}

///subnets///
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "public-sub-1"
  }
}
///aws_internet_gateway///
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id  //attach to vpc

  tags = {
    Name = "internet-gateway"
  }
}