resource "aws_dynamodb_table" "app-dynamodb-table" {
  name             = "${var.env}-infra-app-table"
  hash_key         = var.hash_key
  billing_mode     = "PAY_PER_REQUEST"
  
attribute {
    name = var.hash_key
    type = "S"   #string
  }


tags = {
    Name ="${var.env}-infra-app-table"
    Environment = var.env
  }
}

