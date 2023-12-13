output "vpc_id" {
  value = aws_vpc.main.id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}
output "public_subnet_ids" {
  value = values(aws_subnet.public)[*].id
}
output "private_subnet_ids" {
  value = values(aws_subnet.private)[*].id
}
output "node_subnet_ids" {
  value = values(aws_subnet.node_subnet)[*].id
}

output "nat_eip_ids" {
  value = aws_eip.nat_eip[*].id
}
output "public_instance_eip_ids" {
  value = aws_eip.public_instance_eip[*].id
}
output "public_instance_eip" {
  value = aws_eip.public_instance_eip
}
