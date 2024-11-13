// Define a resource of type 'aws_dynamodb_table'

//DynamoDB is a serverless, NoSQL, 
//fully managed database service with 
//single-digit millisecond response times at any scale,
// enabling you to develop and run modern 
//applications while only paying for what you use

//- DynamoDB (for course progress tracking)
resource "aws_dynamodb_table" "oln-dynamodb" {
  name           = "oln-dynamodb"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Id"


  attribute {
    name = "Id"
    type = "N"
  }


  server_side_encryption {
    enabled = true
  }
}
