variable "region" {
  description = "The AWS region to use"
  type        = string
  default     = "us-east-1"
}

variable "profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "default"
}

variable "backups_bucket" {
  description = "The name of the S3 bucket to store the world in"
  type        = string
  default     = "valheim-world"
}


variable "ram_mb" {
  description = "The amount of RAM to use, in MiBs"
  type        = number
  default     = 8192
}

variable "vcpus" {
  description = "The number of vCPUs to use"
  type        = number
  default     = 1
}

variable "state" {
  description = "Target state of the server ('running', 'paused', or 'stopped')"
  type        = string
  default     = "running"

  validation {
    condition     = contains(["running", "paused", "stopped"], var.state)
    error_message = "state must be 'running', 'paused', or 'stopped'"
  }
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 zone to use, if any"
  type        = string
  nullable    = true
  default     = null
}
