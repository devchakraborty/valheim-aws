resource "aws_s3_bucket" "backups" {
  bucket = var.backups_bucket

  force_destroy = true
}

resource "aws_s3_bucket_acl" "backups_acl" {
  bucket = aws_s3_bucket.backups.id
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
        id   = data.aws_canonical_user_id.current.id
      }
      permission = "FULL_CONTROL"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}


resource "aws_datasync_location_efs" "backups" {
  count               = var.backups ? 1 : 0
  efs_file_system_arn = aws_efs_file_system.server.arn
  subdirectory        = "/backups"

  ec2_config {
    security_group_arns = [aws_security_group.server.arn]
    subnet_arn          = aws_default_subnet.default.arn
  }

  depends_on = [
    aws_efs_mount_target.server,
  ]
}

resource "aws_datasync_location_s3" "backups" {
  count         = var.backups ? 1 : 0
  s3_bucket_arn = aws_s3_bucket.backups.arn
  subdirectory  = "/"
  s3_config {
    bucket_access_role_arn = aws_iam_role.main.arn
  }
}

resource "aws_datasync_task" "sync" {
  count                    = var.backups ? 1 : 0
  name                     = "sync"
  source_location_arn      = aws_datasync_location_efs.backups[0].arn
  destination_location_arn = aws_datasync_location_s3.backups[0].arn
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.server.arn

  options {
    verify_mode      = "POINT_IN_TIME_CONSISTENT"
    bytes_per_second = -1
  }
}

data "archive_file" "sync" {
  count       = var.backups ? 1 : 0
  type        = "zip"
  source_file = "${path.module}/lambda/data_sync.py"
  output_path = "${path.module}/.terraform/tmp/data_sync.zip"
}

resource "aws_iam_role" "sync" {
  count       = var.backups ? 1 : 0
  name_prefix = "${local.service_name}-world-sync-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name = "datasync"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "datasync:StartTaskExecution",
          ]
          Effect   = "Allow"
          Resource = aws_datasync_task.sync[0].arn
        },
      ]
    })
  }

  inline_policy {
    name = "ec2"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ec2:AttachNetworkInterface",
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:DescribeNetworkInterfaces",
          ],
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_lambda_function" "sync" {
  count         = var.backups ? 1 : 0
  function_name = "world-sync"
  role          = aws_iam_role.sync[0].arn
  handler       = "data_sync.main"
  runtime       = "python3.9"
  memory_size   = 128
  timeout       = 300

  environment {
    variables = {
      DATA_SYNC_TASK_ARN = aws_datasync_task.sync[0].arn
    }
  }

  filename         = data.archive_file.sync[0].output_path
  source_code_hash = data.archive_file.sync[0].output_base64sha256
}

resource "aws_cloudwatch_event_rule" "sync" {
  count       = var.backups ? 1 : 0
  name        = "sync"
  description = "Sync backups upon server shutdown"
  event_pattern = jsonencode({
    source = [
      "aws.ecs"
    ]
    "detail-type" = [
      "ECS Task State Change"
    ]
    detail = {
      clusterArn = [
        aws_ecs_cluster.server.arn
      ]
      lastStatus = [
        "STOPPED"
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "sync" {
  count = var.backups ? 1 : 0
  rule  = aws_cloudwatch_event_rule.sync[0].name
  arn   = aws_lambda_function.sync[0].arn
}

resource "aws_lambda_permission" "sync" {
  count         = var.backups ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sync[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.sync[0].arn
}
