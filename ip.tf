resource "aws_eip" "server" {
  count = var.state != "stopped" ? 1 : 0
}


resource "aws_lb" "main" {
  count              = var.state != "stopped" ? 1 : 0
  name_prefix        = local.service_name
  internal           = false
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id     = aws_default_subnet.default.id
    allocation_id = aws_eip.server[0].id
  }
}

resource "aws_lb_target_group" "server" {
  count                = var.state != "stopped" ? 3 : 0
  name_prefix          = local.service_name
  port                 = var.server_port + count.index
  protocol             = "UDP"
  vpc_id               = aws_default_vpc.default.id
  target_type          = "ip"
  deregistration_delay = 0

  health_check {
    enabled  = true
    protocol = "HTTP"
    port     = var.status_http_port
    path     = "/status.json"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_target_group" "status" {
  name_prefix          = local.service_name
  port                 = var.status_http_port
  protocol             = "TCP"
  vpc_id               = aws_default_vpc.default.id
  target_type          = "ip"
  deregistration_delay = 0

  health_check {
    enabled  = true
    protocol = "HTTP"
    port     = var.status_http_port
    path     = "/status.json"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_target_group" "supervisor" {
  count                = (var.state != "stopped" && var.supervisor_http) ? 1 : 0
  name_prefix          = local.service_name
  port                 = var.supervisor_http_port
  protocol             = "TCP"
  vpc_id               = aws_default_vpc.default.id
  target_type          = "ip"
  deregistration_delay = 0

  health_check {
    enabled  = true
    protocol = "HTTP"
    port     = var.status_http_port
    path     = "/status.json"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_listener" "server" {
  count             = var.state != "stopped" ? 3 : 0
  load_balancer_arn = aws_lb.main[0].arn
  port              = var.server_port + count.index
  protocol          = "UDP"

  default_action {
    target_group_arn = aws_lb_target_group.server[count.index].arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "status" {
  count             = var.state != "stopped" ? 1 : 0
  load_balancer_arn = aws_lb.main[0].arn
  port              = var.status_http_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.status.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "supervisor" {
  count             = (var.state != "stopped" && var.supervisor_http) ? 1 : 0
  load_balancer_arn = aws_lb.main[0].arn
  port              = var.supervisor_http_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.supervisor[0].arn
    type             = "forward"
  }
}

resource "aws_route53_record" "server" {
  count   = (var.route53_zone_id != null && var.state != "stopped") ? 1 : 0
  zone_id = var.route53_zone_id
  name    = "${local.service_name}.${data.aws_route53_zone.zone[0].name}"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.server[0].public_ip]
}
