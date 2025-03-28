module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
}
module "loadbalancer" {
    source = "./modules/loadbalancer"
    vpc_id = module.vpc.vpc_id
    sn_pub01 = module.vpc.sn_pub01
    sn_pub02 = module.vpc.sn_pub02
}
