resource "aws_sqs_queue" "main" {
  name = "${terraform.workspace}-sqs"
}

# how to referenceto workspaces?
# syntax: terraform.workspaces
