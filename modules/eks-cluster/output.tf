output "vpc_id" {
    value = aws_vpc.test-vpc.id
}

output "subnetprivate_id" {
    value = aws_subnet.private_subnet[*].id
}

output "subnetpublic_id" {
    value = aws_subnet.public_subnet[*].id
}