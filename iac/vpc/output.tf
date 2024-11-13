output "vpc_id" {
    value = aws_vpc.main.id
}
output "public_subnet-1a_id" {
    value = aws_subnet.public_subnet-1a.id
}
output "public_subnet-1b_id" {
    value = aws_subnet.public_subnet-1b.id
}
output "private_subnet-1a_id" {
    value = aws_subnet.private_subnet-1a.id
}
output "private_subnet-1b_id" {
    value = aws_subnet.private_subnet-1b.id
}
output "aws_security_group_id" {
    value = aws_security_group.ssh_access.id
}