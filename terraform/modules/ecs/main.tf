resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.execution_role_arn
  container_definitions    = var.container_definitions

  # EFS-backed volumes
  volume {
    name = "postgres_data"
    efs_volume_configuration {
      file_system_id = var.postgres_file_system_id
      root_directory = "/var/lib/postgresql/data/"
    }
  }

  volume {
    name = "static_volume"
    efs_volume_configuration {
      file_system_id = var.static_file_system_id
      root_directory = "/static"
    }
  }

  volume {
    name = "media_volume"
    efs_volume_configuration {
      file_system_id = var.media_file_system_id
      root_directory = "/media"
    }
  }
}

resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}
