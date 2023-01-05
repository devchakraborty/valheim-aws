

resource "aws_default_vpc" "default" {
}

resource "aws_default_subnet" "default" {
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_security_group" "server" {
  name_prefix = local.service_name
  vpc_id      = aws_default_vpc.default.id
}

resource "aws_security_group_rule" "ssh" {
  description       = "Allow inbound traffic on port 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group_rule" "valheim" {
  description       = "Allow inbound traffic on ports ${var.server_port} - ${var.server_port + 2}"
  type              = "ingress"
  from_port         = var.server_port
  to_port           = var.server_port + 2
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group_rule" "efs" {
  description       = "Allow inbound traffic for EFS"
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group_rule" "status" {
  description       = "Allow inbound traffic for status"
  type              = "ingress"
  from_port         = var.status_http_port
  to_port           = var.status_http_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group_rule" "supervisor" {
  count             = var.supervisor_http ? 1 : 0
  description       = "Allow inbound traffic for supervisor"
  type              = "ingress"
  from_port         = var.supervisor_http_port
  to_port           = var.supervisor_http_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}

resource "aws_security_group_rule" "out" {
  description       = "Allow outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.server.id
}
