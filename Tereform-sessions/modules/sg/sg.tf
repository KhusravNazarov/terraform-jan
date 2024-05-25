resource "aws_security_group" "web" {
  name        = "${var.env}-web"
  description = "Allow TLS inbound traffic and all outbound traffic"
  

  tags = {
    Name = "web"
  }
}
//how to reference ti Resiyrce?
//In order to Reference to Resource, we use lables (firstlable.secondlable.attribute)
resource "aws_vpc_security_group_ingress_rule" "allow-http" {
    count = length(var.ports)
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = element(var.ports, count.index)
  ip_protocol       = "tcp"
  to_port           = element(var.ports, count.index)
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}