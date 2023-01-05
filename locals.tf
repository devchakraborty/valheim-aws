locals {
  service_name         = lower(replace(var.server_name, "/[\\s-_]/", ""))
  cluster_name         = "${local.service_name}-${random_string.cluster_suffix.result}"
  valheim_docker_image = "lloesche/valheim-server:latest"
}
