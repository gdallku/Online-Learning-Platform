resource "aws_security_group" "oln_security_group_rds" {
  name        = "oln_security_group_rds"
  description = "Security Group for RDS"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // represents all protocols    per me dal ne te gjitha portet
    cidr_blocks = ["0.0.0.0/0"] 
  }
}



resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh_access"
  vpc_id      = aws_vpc.main.id


  ingress {
    description = "Allow SSH from my computer"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }
  ingress {
    description = "Allow all traffic through HTTP"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group" "oln_security_group_efs" {
  name        = "oln_security_group_efs"
  description = "Security Group for EFS"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
