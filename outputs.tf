output "server_ip" {
  value       = var.state != "stopped" ? aws_eip.server[0].public_ip : null
  description = "The IP address of the Valheim server"
}

output "domain_name" {
  value       = var.state != "stopped" ? "${local.service_name}.${data.aws_route53_zone.zone[0].name}" : null
  description = "The domain name of the Valheim server"
}

output "security_group_id" {
  value       = aws_security_group.server.id
  description = "The ID of the security group used by the Valheim server"
}

output "iam_role_name" {
  value       = aws_iam_role.main.name
  description = "The name of the IAM role used by the Valheim server"
}
