module "eks" {
  source                = "../../modules/eks"
  cluster_name          = var.cluster_name
  vpc_id                = module.vpc.vpc_id
  node_subnet_ids       = module.vpc.node_subnet_ids
  node_instance_type    = var.node_instance_type
  cluster_sg_rules_cidr = var.cluster_sg_rules_cidr
  cluster_sg_rules_sg   = var.cluster_sg_rules_sg
  node_sg_rules_cidr    = var.node_sg_rules_cidr
  node_sg_rules_sg      = var.node_sg_rules_sg
}
