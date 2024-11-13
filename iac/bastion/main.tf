variable "vpc_id" {}
variable "public_subnet-1a_id" {}
variable "public_subnet-1b_id" {}
variable "aws_security_group_id" {}

resource "aws_instance" "web_server" {
  ami           = "ami-0dfdff9941ebfbd48"
  instance_type = "t2.micro"

  subnet_id     = var.public_subnet-1a_id

  vpc_security_group_ids = [
   var.aws_security_group_id
  ]
}



resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id

  tags = {
    Name = "Gtest-eip"
  }
}