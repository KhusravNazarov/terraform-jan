resource "aws_instance" "web" {
  depends_on = [ null_resource.main ]  // explicit dependencies
  ami           = "ami-01cd4de4363ab6ee8"     //Data type is string , hard coded
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id] //plural expects list
    key_name = aws_key_pair.main.id  //implicit dependencies reference to resource 
    provisioner "file" {
      source = "/Users/macbook/Desktop/terraform-jan/Tereform-sessions/session8.1/index.html" /// the path where your file exist , local machine
      destination = "/tmp/index.html" /// the path where you wanna send your file , remote 
    }
    provisioner "remote-exec" {
      inline = [ 
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
       ]
      connection {
      type = "ssh"
      user = "ec2-user"  //username
      host = self.public_ip // public ip of instance 
      private_key = file("~/.ssh/id_rsa") //private kay o
    }
    }
    connection {
      type = "ssh"
      user = "ec2-user"  //username
      host = self.public_ip // public ip of instance 
      private_key = file("~/.ssh/id_rsa") //private kay o
    }
  tags = {
    Name = "${var.env}-instance",
    Name1 = format("%s-instance", var.env)
    enviroment = var.env
  }
}
resource "aws_security_group" "main" {
  name        = "main"
  description = "Allow SSH and HTTP "

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // all ports, protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_key_pair" "main" {
  key_name = "local-mac-new"
  public_key = file("~/.ssh/id_rsa.pub") 
}
resource "null_resource" "main" {
  provisioner "local-exec" {
    command = "echo  'Testing local exec, fiel , remote-exec provisioners ' > index.html "
  }
}