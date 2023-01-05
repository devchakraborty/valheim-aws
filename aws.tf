data "aws_canonical_user_id" "current" {}

data "aws_ec2_instance_types" "server" {
  filter {
    name   = "current-generation"
    values = ["true"]
  }

  filter {
    name   = "memory-info.size-in-mib"
    values = [var.ram_mb]
  }

  filter {
    name   = "processor-info.supported-architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "vcpu-info.default-vcpus"
    values = [var.vcpus]
  }
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "zone" {
  count   = var.route53_zone_id == null ? 0 : 1
  zone_id = var.route53_zone_id
}
