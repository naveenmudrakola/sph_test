provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
  iam_role_name = var.iam_role_name
}

module "ecs" {
  source               = "./modules/ecs"
  ecs_cluster_name     = var.ecs_cluster_name
  task_definition_atts = {
    family  = var.task_definition_family
    cpu     = var.task_definition_cpu
    memory  = var.task_definition_memory
  }
  container_def_image  = var.container_image
  container_port       = var.container_port
  host_port            = var.host_port
  desired_count        = var.ecs_service_desired_count
  subnets              = var.network_subnets
  security_groups      = var.security_groups
  execution_role_arn   = module.iam.execution_role_arn
}
