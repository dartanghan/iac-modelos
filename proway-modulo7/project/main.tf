module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
}
module "loadbalancer" {
    source = "./modules/loadbalancer"
    dart_nginx_sg_id = module.vpc.dart_nginx_sg_id
}
