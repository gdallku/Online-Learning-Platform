resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name = "GPublic Subnet1a"
  }
}
resource "aws_subnet" "public_subnet-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name = "GPublic Subnet1b"
  }
}
resource "aws_subnet" "private_subnet-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true


  tags = {
    Name = "GPrivate Subnet1a"
  }
}
resource "aws_subnet" "private_subnet-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name = "GPrivate Subnet1b"
  }
}



// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Gigw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Groute-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet-1a.id
  route_table_id = aws_route_table.public.id
}


//nacl  network acl
//- NACLs with custom rules for different subnets.
resource "aws_network_acl" "bar" {
  vpc_id = aws_vpc.main.id
}

resource "aws_network_acl_rule" "nacl1a" {
  network_acl_id = aws_network_acl.bar.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.3.0/24"
  from_port      = 5432
  to_port        = 5432
}
resource "aws_network_acl_rule" "nacl1b" {
  network_acl_id = aws_network_acl.bar.id
  rule_number    = 201
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.4.0/24"
  from_port      = 5432
  to_port        = 5432
}

