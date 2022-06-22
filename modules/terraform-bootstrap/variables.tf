######################
# Mandatory settings #
######################

variable "aws_profile" {
  type = string
  description = "The name of the AWS profile to use"
  sensitive = false
}

variable "project_name" {
  type = string
  description = "Short project name used as part of S3-bucket name, use [a-z_-]"
  sensitive = false
}

variable "project_tag" {
  type = string
  description = "Name for the 'Project'-tag of created resource(s), eg. 'CLV+'"
  sensitive = false
}

#####################
# Optional settings #
#####################

variable "aws_region" {
  type = string
  description = "AWS Region identifier to use"
  default = "eu-central-1"
  sensitive = false
}