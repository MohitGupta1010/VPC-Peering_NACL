output "subnet-id" {
  value = aws_subnet.custom-subnet.id
}

output "custom-subnet-cidr-block" {
  value = aws_subnet.custom-subnet.cidr_block
}
