output "server_ip" {
  value       = var.state != "stopped" ? aws_eip.server[0].public_ip : null
  description = "The IP address of the Valheim server"
}

output "domain_name" {
  value       = var.state != "stopped" ? "${local.service_name}.${data.aws_route53_zone.zone[0].name}" : null
  description = "The domain name of the Valheim server"
}
