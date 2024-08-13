terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2" 
}

module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = "10.0.0.0/16"
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

module "efs_db" {
  source        = "./modules/efs"
  creation_token = "db_data"
  subnet_id     = module.vpc.subnet1_id
  security_groups = [module.security_group.security_group_id]
}

module "efs_static" {
  source        = "./modules/efs"
  creation_token = "static_data"
  subnet_id     = module.vpc.subnet2_id
  security_groups = [module.security_group.security_group_id]
}

module "ecs" {
  source              = "./modules/ecs"
  cluster_name        = "django-cluster"
  family              = "django-task"
  cpu                 = "256"
  memory              = "512"
  execution_role_arn  = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  container_definitions = file("${path.module}/ecs_container_definitions.json")
  service_name        = "django-service"
  desired_count       = 2
  subnets             = [module.vpc.subnet1_id, module.vpc.subnet2_id]
  security_groups     = [module.security_group.security_group_id]
}