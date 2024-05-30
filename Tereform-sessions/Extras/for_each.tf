resource "aws_sqs_queue" "for_each_queue" {
    for_each = {
        first = "first-for_each"
        second = "second-for_each"
        third = "third-for_each"
    }
     name = each.value
    
  
}