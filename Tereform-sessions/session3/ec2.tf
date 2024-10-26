resource "aws_instance" "web" {
  count = 3
  ami           = data.aws_ami.amazon_linux.id     //Data type is string , hard coded
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id] //plural expects list

  tags = {
    Name = "${var.env}-instance",
    Name1 = format("%s-instance", var.env)
    enviroment = var.env
  }
}








