resource "aws_sqs_queue" "count_queue" {
    count = length(var.naems)
     name = element(var.naems, count.index)
    
  
}
variable "naems" {
  type = list(string)
  description = "a list of sqs names"
  default = [ "first", "second", "third" ]
}