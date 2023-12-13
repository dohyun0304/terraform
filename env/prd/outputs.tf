output "vpc_id" {
  value = module.vpc.vpc_id
}
output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_subent_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subent_ids" {
  value = module.vpc.private_subnet_ids
}

output "nat_eip_ids" {
  value = module.vpc.nat_eip_ids
}

output "public_instance_eip_ids" {
  value = module.vpc.public_instance_eip_ids
}