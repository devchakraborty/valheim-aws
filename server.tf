resource "aws_ecs_cluster" "server" {
  name = local.cluster_name
}

resource "aws_ecs_service" "server" {
  count                              = var.state != "stopped" ? 1 : 0
  name                               = local.service_name
  cluster                            = aws_ecs_cluster.server.id
  task_definition                    = aws_ecs_task_definition.server.arn
  desired_count                      = var.state == "running" ? 1 : 0
  launch_type                        = "FARGATE"
  enable_execute_command             = true
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  force_new_deployment               = true

  network_configuration {
    subnets          = [aws_default_subnet.default.id]
    security_groups  = [aws_security_group.server.id]
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = range(3)
    content {
      target_group_arn = aws_lb_target_group.server[load_balancer.value].arn
      container_name   = local.service_name
      container_port   = var.server_port + load_balancer.value
    }
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.status.arn
    container_name   = local.service_name
    container_port   = var.status_http_port
  }

  dynamic "load_balancer" {
    for_each = var.supervisor_http ? [1] : []
    content {
      target_group_arn = aws_lb_target_group.supervisor[0].arn
      container_name   = local.service_name
      container_port   = var.supervisor_http_port
    }
  }
}

resource "aws_ecs_task_definition" "server" {
  family                   = local.service_name
  requires_compatibilities = ["FARGATE"]
  memory                   = var.ram_mb
  cpu                      = "${var.vcpus} vCPU"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.main.arn
  task_role_arn            = aws_iam_role.main.arn

  container_definitions = jsonencode([
    {
      name      = local.service_name
      image     = local.valheim_docker_image
      essential = true
      portMappings = [
        {
          containerPort = var.server_port
          hostPort      = var.server_port
          protocol      = "udp"
        },
        {
          containerPort = var.server_port + 1
          hostPort      = var.server_port + 1
          protocol      = "udp"
        },
        {
          containerPort = var.server_port + 2
          hostPort      = var.server_port + 2
          protocol      = "udp"
        },
        {
          containerPort = var.status_http_port
          hostPort      = var.status_http_port
          protocol      = "tcp"
        },
        {
          containerPort = var.supervisor_http_port
          hostPort      = var.supervisor_http_port
          protocol      = "tcp"
        },
      ]
      environment = [for key, value in local.container_env : { name = key, value = value }]

      mountPoints = [
        { sourceVolume = local.service_name, containerPath = "/config" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.server.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "${local.service_name}-"
        }
      }
    }
  ])

  volume {
    name = local.service_name
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.server.id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.server.id
        iam             = "ENABLED"
      }
    }
  }
}


resource "aws_efs_file_system" "server" {
  tags = {
    Name = local.service_name
  }
}

resource "aws_efs_mount_target" "server" {
  file_system_id  = aws_efs_file_system.server.id
  subnet_id       = aws_default_subnet.default.id
  security_groups = [aws_security_group.server.id]
}

resource "aws_efs_access_point" "server" {
  file_system_id = aws_efs_file_system.server.id
}

resource "aws_cloudwatch_log_group" "server" {
  name_prefix = "/ecs/${local.service_name}"
}

resource "random_string" "cluster_suffix" {
  length  = 8
  special = false
  upper   = false
}
