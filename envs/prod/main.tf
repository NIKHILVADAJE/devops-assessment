provider "aws" { region = "us-east-1" }

module "network" {
  source   = "../../modules/network"
  vpc_cidr = var.vpc_cidr
  env      = "prod"
}

module "ecs" {
  source           = "../../modules/ecs"
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  env              = "prod"
}

module "rds" {
  source                  = "../../modules/rds"
  vpc_id                  = module.network.vpc_id
  private_subnet_id       = module.network.private_subnet_id
  instance_class          = var.instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
  env                     = "prod"
}
