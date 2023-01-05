data "aws_canonical_user_id" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "zone" {
  count   = var.route53_zone_id == null ? 0 : 1
  zone_id = var.route53_zone_id
}
