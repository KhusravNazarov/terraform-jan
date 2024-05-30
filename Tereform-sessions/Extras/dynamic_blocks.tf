resource "aws_security_group" "example" {
    name = "sg"
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    dynamic "ingress"  {
    
    for_each = var.ports
    iterator = ports
    content {
        from_port = ports.value.port
        to_port = ports.value.port
        protocol = ports.value.protocol
         cidr_blocks = ["0.0.0.0/0"]
    }
  
}
}
variable "ports" {
  type = list(object({
    port = number 
    protocol = string
  }
  ))
  default = [ {
    port = 80
    protocol = "tcp"
  },
  {
    port = 22
    protocol = "tcp"
  } ]
}
