module "roboshop_vpc" {
  source = "git::https://github.com/sowmithcloud/terraform-aws-vpc.git?ref=main"
  vpc_cidr = var.vpc_cidr
  common_tags = var.common_tags
  project_name = var.project_name
  environment = var.environment

  public_subnets_cidr = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
}