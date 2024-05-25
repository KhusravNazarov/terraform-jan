resource "aws_instance" "web" {
 
  ami           = var.ami     //Data type is string , hard coded
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg //plural expects list

  tags = {
    Name = "${var.env}-instance",
    enviroment = var.env
  }
}
