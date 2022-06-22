terraform {
  required_version = ">= 0.14.8"
}

locals {
  tags = {
    Automation = "Terraform"
    Project = var.project_tag
  }

  s3_bucket_name = "${var.aws_profile}-tf-state-for-${var.project_name}-${var.aws_region}"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
