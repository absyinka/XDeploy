terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source             = "./modules/vpc"
  cidr_block         = "10.0.0.0/16"
  subnet1_cidr_block = "10.0.1.0/24"
  subnet2_cidr_block = "10.0.2.0/24"
}

module "security_group" {
  source      = "./modules/security_group"
  vpc_id      = module.vpc.vpc_id
  from_port   = 8000
  to_port     = 8000
  cidr_blocks = ["0.0.0.0/0"]
}

module "efs" {
  source          = "./modules/efs"
  creation_token  = "efs-token"
  subnet_id       = module.vpc.subnet1_id
  security_groups = [module.security_group.security_group_id]
}

module "iam_roles" {
  source                    = "./modules/iam_roles"
  dockerhub_credentials_arn = module.secrets_manager.dockerhub_credentials_arn
}

module "secrets_manager" {
  source             = "./modules/secrets_manager"
  secret_name        = "dockerhub_cred"
  dockerhub_username = var.dockerhub_username
  dockerhub_token    = var.dockerhub_token
}

module "ecs" {
  source                  = "./modules/ecs"
  cluster_name            = "django-cluster"
  family                  = "django-task"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = module.iam_roles.ecs_task_execution_role_arn
  container_definitions   = file("./modules/ecs/ecs_container_definitions.json")
  service_name            = "django-service"
  desired_count           = var.ecs_desired_count
  subnets                 = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  security_groups         = [module.security_group.security_group_id]
  postgres_file_system_id = module.efs.postgres_file_system_id
  static_file_system_id   = module.efs.static_file_system_id
  media_file_system_id    = module.efs.media_file_system_id
}