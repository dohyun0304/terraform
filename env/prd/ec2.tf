/*
module "public_ec2_instance_gw" {
  source                  = "../../modules/ec2/public_ec2"
  instance_count          = var.public_instance_count
  ami_id                  = var.public_ami_id
  instance_type           = var.public_instance_type
  subnet_id               = module.vpc.public_subnet_ids[0]
  public_instance_eip_ids = module.vpc.public_instance_eip_ids
  name                    = var.public_name
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  public_instance_sg_rule = var.public_instance_sg_rule
}

module "private_ec2_instance_for_service" {
  source                   = "../../modules/ec2/private_ec2"
  instance_count           = var.private_instance_count
  ami_id                   = var.private_ami_id
  instance_type            = var.private_instance_type
  subnet_id                = module.vpc.private_subnet_ids[0]
  name                     = var.private_name
  environment              = var.environment
  vpc_id                   = module.vpc.vpc_id
  private_instance_sg_rule = var.private_instance_sg_rule
}
*/

/* 새로운 용도의 ec2가 필요하면 추가 module block 생성
module "private_ec2_instance_for_service" {

  source         = "../../modules/ec2/private_ec2"
  instance_count = var.private_instance_count
  ami_id         = var.private_ami_id
  instance_type  = var.private_instance_type
  subnet_id      = module.vpc.private_subnet_ids[0]
  name           = var.private_name
  environment    = var.environment
}
*/
