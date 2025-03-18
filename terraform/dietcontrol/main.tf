module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
    project_region = var.project_region
}
module "ec2" {
    source = "./modules/ec2"
    project_name = var.project_name
    project_region = var.project_region
    vpc_id = module.vpc.vpc_id
    subnet_priv_a_id = module.vpc.subnet_priv_a_id
    subnet_priv_b_id = module.vpc.subnet_priv_b_id
}

module ecr {
    source = "./modules/ecr"
    project_name = var.project_name
    project_region = var.project_region
    vpc_id = module.vpc.vpc_id
    ec2_security_group_id = module.ec2.ec2_security_group_id
    subnet_priv_a_id = module.vpc.subnet_priv_a_id
    subnet_priv_b_id = module.vpc.subnet_priv_b_id
    subnet_pub_a_id = module.vpc.subnet_pub_a_id
    subnet_pub_b_id = module.vpc.subnet_pub_b_id
}