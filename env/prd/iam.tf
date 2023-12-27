module "iam" {
  source = "../../modules/iam"

  environment = var.environment
  terraform   = var.terraform
}