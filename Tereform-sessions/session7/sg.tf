resource "aws_security_group" "ec2" {
 name = replace(local.Name, "rtype", "ec2-sg") 
 vpc_id = aws_default_vpc.main.id
 tags = merge(
        {Name = replace(local.Name, "rtype", "ec2-sg")}, 
        local.common_tags
 )


    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    dynamic "ingress"  {
    
    for_each = var.ec2-ports
    iterator = ports
    content {
        from_port = ports.value.port
        to_port = ports.value.port
        protocol = ports.value.protocol
        security_groups = [aws_security_group.alb.id]
    }
  
}
}

resource "aws_security_group" "alb" {
 name = replace(local.Name, "rtype", "alb-sg") 
 vpc_id = aws_default_vpc.main.id
 tags = merge(
        {Name = replace(local.Name, "rtype", "alb-sg")}, 
        local.common_tags
 )


    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    dynamic "ingress"  {
    
    for_each = var.alb-ports
    iterator = ports
    content {
        from_port = ports.value.port
        to_port = ports.value.port
        protocol = ports.value.protocol
         cidr_blocks = ["0.0.0.0/0"]
    }
  
}
}

