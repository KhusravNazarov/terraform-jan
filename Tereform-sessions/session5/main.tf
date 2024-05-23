resource "aws_sqs_queue" "main" {
  name = replace(local.name, "res-type", "aqs" )
  tags = local.common_tags
}
//reference to locals
// local.local_name
resource "aws_db_instance" "main" {
  allocated_storage    = 10
  db_name              = "mydb"
  identifier = replace(local.name, "res-type", "rds" )
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = random_password.db_password.result
  tags = local.common_tags
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = var.env != "prod" ? true : false 
  final_snapshot_identifier =  var.env != "prod" ? null : "${var.env}-final-snapshot"
}
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "%"
}