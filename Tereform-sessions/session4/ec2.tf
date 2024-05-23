resource "aws_instance" "web" {
 
  ami           =  data.aws_ami.amazon_linux_2023.image_id    //Data type is string , hard coded
  instance_type = var.instance_type 
  vpc_security_group_ids = [aws_security_group.web.id] //plural expects list
   user_data = data.template_file.userdata.rendered
  tags = {
    Name = "${var.env}-instance",
    Name1 = format("%s-instance", var.env),
    enviroment = var.env

  }
}
# referencing to data source --->> data.aws_ami.amazon_linux_2023.image_id  