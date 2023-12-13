module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  node_subnets       = var.node_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  public_route_cidrs = var.public_route_cidrs
  node_route_cidrs   = var.node_route_cidrs
}
